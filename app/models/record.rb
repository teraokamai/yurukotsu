class Record < ApplicationRecord
  belongs_to :account
  belongs_to :category

  validates :do_on, presence: { message: "は必須項目です。" }
end
