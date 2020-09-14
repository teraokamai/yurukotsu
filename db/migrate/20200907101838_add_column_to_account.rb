class AddColumnToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :username, :string
  end
end
