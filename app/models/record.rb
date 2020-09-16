class Record < ApplicationRecord
  belongs_to :account
  belongs_to :category
  has_rich_text :content

  validates :do_on, :start_at, :end_at, :summary, :total, :calculation, presence: { message: 'は必須項目です。' }
  validates :total, numericality: { greater_than_or_equal_to: 0, message: '開始時刻は終了時刻よりも前に設定して下さい。' }
  validates :summary, length: { maximum: 20 }
end
