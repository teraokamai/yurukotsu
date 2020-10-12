require 'rails_helper'

RSpec.describe Record, type: :model do
  it '日付、開始時刻、終了時刻、概要、内容、合計時間、アカウント、カテゴリーがあれば有効であること' do
    @account = Account.new( 
      email:      "test@example.com",
      password:   "test123"
    )

    @category = Category.new(
      name: 'サンプルカテゴリ',
      account: @account,
      is_default: false
    )

    @record = Record.new(
      do_on: '2020-09-22',
      start_at: '10:00:00',
      end_at: '11:30:00',
      summary: 'テスト',
      content: '',
      total: 90,
      calculation: true,
      account: @account,
      category: @category
    )
    expect(@record).to be_valid
  end

  it '日付がなければ無効であること' do
    @record = Record.new(do_on: nil)
    @record.valid?
    expect(@record.errors[:do_on]).to include('は必須項目です。')
  end
  
  it '開始時刻がなければ無効であること' do
    @record = Record.new(do_on: nil)
    @record.valid?
    expect(@record.errors[:do_on]).to include('は必須項目です。')
  end
  
  it '終了時刻がなければ無効であること' do
    @record = Record.new(do_on: nil)
    @record.valid?
    expect(@record.errors[:do_on]).to include('は必須項目です。')
  end
  
  it '概要がなければ無効であること' do
    @record = Record.new(do_on: nil)
    @record.valid?
    expect(@record.errors[:do_on]).to include('は必須項目です。')
  end
  
  it '合計時間がなければ無効であること' do
    @record = Record.new(total: nil)
    @record.valid?
    expect(@record.errors[:do_on]).to include('は必須項目です。')
  end
  
  it '計算フラグがなければ無効であること' do
    @record = Record.new(calculation: nil)
    @record.valid?
    expect(@record.errors[:do_on]).to include('は必須項目です。')
  end
end
