class Record < ApplicationRecord
  belongs_to :account
  belongs_to :category
  has_rich_text :content

  validates :do_on, :start_at, :end_at, :summary, :total, :calculation, presence: { message: "は必須項目です。" }
end
