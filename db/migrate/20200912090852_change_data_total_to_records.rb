class ChangeDataTotalToRecords < ActiveRecord::Migration[6.0]
  def self.up
    change_column :records, :total, :'integer USING CAST(total AS integer)'
  end

  def self.down
      change_column :records, :total, :string
  end
end
