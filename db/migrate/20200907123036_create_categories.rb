class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      # カテゴリー名
      t.string :name

      t.references :account, foreign_key: true
      t.timestamps
    end
  end
end
