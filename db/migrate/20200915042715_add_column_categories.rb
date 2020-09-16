class AddColumnCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :is_default, :boolean
  end
end
