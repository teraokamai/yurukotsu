class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      # 日付
      t.date :do_on, null: false
      # 開始時刻
      t.time :start_at, null: false
      # 終了時刻
      t.time :end_at, null: true
      # 概要
      t.string :sammary, nul: true
      # 内容
      t.text :content, null: true
      # 合計時間
      t.time :total, null: true
      # 計算に含めるか
      t.boolean :calculation, null: false, defaulst: false

      t.references :account, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
