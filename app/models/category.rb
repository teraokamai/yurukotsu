class Category < ApplicationRecord
  has_many :record
  belongs_to :account

  validates :name, presence: { message: 'は必須項目です。' }
end
