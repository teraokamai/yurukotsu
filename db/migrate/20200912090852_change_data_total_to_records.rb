class ChangeDataTotalToRecords < ActiveRecord::Migration[6.0]
  def change
    change_column :records, :total, :integer
  end
end
