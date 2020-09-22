class RemoveUsernameFromAccounts < ActiveRecord::Migration[6.0]
  def up
    remove_column :accounts, :username, :string
  end

  def down
    add_column :accounts, :username, :string
  end
end
