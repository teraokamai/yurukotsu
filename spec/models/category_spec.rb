require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'カテゴリ名、作成日、更新日、デフォルトフラグ、アカウントがあれば有効であること' do
    @account = Account.new( 
      email:      "test@example.com",
      password:   "test123"
    ) 
    
    @category = Category.new(
      name: 'サンプルカテゴリ',
      account: @account,
      is_default: false
    )
    expect(@category).to be_valid
  end

  it 'カテゴリ名がなければ無効であること' do
    @category = Category.new(name: nil)
    expect(@category.valid?).to eq(false)
  end
end
