require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'メールアドレスとパスワードがあれば有効であること' do
    @account = Account.new(
      email: 'sample@sample.com',
      password: 'sample123'
    )
    expect(@account).to be_valid
  end

  it 'メールアドレスがなければ無効であること' do
    @account = Account.new(email: nil)
    expect(@account.valid?).to eq(false)
  end

  it 'パスワードがなければ無効であること' do
    @account = Account.new(password: nil)
    expect(@account.valid?).to eq(false)
  end

  it 'メールアドレスが重複している場合は無効であること' do
    Account.create(
      email:      "test@example.com",
      password:   "test123"
    )

    @account = Account.new( 
      email:      "test@example.com",
      password:   "test456"
    ) 

    @account.valid?
    expect(@account.valid?).to eq(false)
  end
end
