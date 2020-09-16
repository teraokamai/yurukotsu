# frozen_string_literal: true

module RuboCop
  module Cop
    # A mixin to extend cops for Active Record features
    module ActiveRecordHelper
      extend NodePattern::Macros

      WHERE_METHODS = %i[where rewhere].freeze

      def_node_search :find_set_table_name, <<~PATTERN
        (send self :table_name= {str sym})
      PATTERN

      def_node_search :find_belongs_to, <<~PATTERN
        (send nil? :belongs_to {str sym} ...)
      PATTERN

      def external_dependency_checksum
        return @external_dependency_checksum if defined?(@external_dependency_checksum)

        schema_path = RuboCop::Rails::SchemaLoader.db_schema_path
        return nil if schema_path.nil?

        schema_code = File.read(schema_path)

        @external_dependency_checksum ||= Digest::SHA1.hexdigest(schema_code)
      end

      def schema
        RuboCop::Rails::SchemaLoader.load(target_ruby_version)
      end

      def table_name(class_node)
        table_name = find_set_table_name(class_node).to_a.last&.first_argument
        return table_name.value.to_s if table_name

        namespaces = class_node.each_ancestor(:class, :module)
        [class_node, *namespaces]
          .reverse
          .map { |klass| klass.identifier.children[1] }.join('_')
          .tableize
      end

      # Resolve relation into column name.
      # It just returns column_name if the column exists.
      # Or it tries to resolve column_name as a relation.
      # It returns `nil` if it can't resolve.
      #
      # @param name [String]
      # @param class_node [RuboCop::AST::Node]
      # @param table [RuboCop::Rails::SchemaLoader::Table]
      # @return [String, nil]
      def resolve_relation_into_column(name:, class_node:, table:)
        return unless table
        return name if table.with_column?(name: name)

        find_belongs_to(class_node) do |belongs_to|
          next unless belongs_to.first_argument.value.to_s == name

          fk = foreign_key_of(belongs_to) || "#{name}_id"
          return fk if table.with_column?(name: fk)
        end
        nil
      end

      def foreign_key_of(belongs_to)
        options = belongs_to.last_argument
        return unless options.hash_type?

        options.each_pair.find do |pair|
          next unless pair.key.sym_type? && pair.key.value == :foreign_key
          next unless pair.value.sym_type? || pair.value.str_type?

          break pair.value.value.to_s
        end
      end

      def in_where?(node)
        send_node = node.each_ancestor(:send).first
        send_node && WHERE_METHODS.include?(send_node.method_name)
      end
    end
  end
end
