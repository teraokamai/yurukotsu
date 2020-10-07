require 'rails_helper'

RSpec.describe "CategoriesController", type: :request do
  describe 'GET #index' do
    context '未ログインユーザーの場合' do
      it 'レスポンスコードが302であること' do
        get categories_url
        expect(response.status).to eq 302
      end

      it 'サインインページに遷移' do
        get categories_url
        expect(response).to redirect_to "/accounts/sign_in"
      end
    end

    context 'ログインユーザーの場合' do
      before do
        account = FactoryBot.create(:account)
        login_as(account) 
      end

      it 'レスポンスコードが200であること' do
        get categories_url
        expect(response.status).to eq 200
      end

      after do
        logout(@account)
      end
    end
  end

  describe 'GET #new' do
    context '未ログインユーザーの場合' do
      it 'レスポンスコードが302であること' do
        get new_category_path
        expect(response.status).to eq 302
      end

      it 'サインインページに遷移' do
        get new_category_path
        expect(response).to redirect_to "/accounts/sign_in"
      end
    end

    context 'ログインユーザーの場合' do
      before do
        account = FactoryBot.create(:account)
        login_as(account) 
      end

      it 'レスポンスコードが200であること' do
        get new_category_path
        expect(response.status).to eq 200
      end

      after do
        logout(@account)
      end
    end
  end

  # describe 'GET #edit' do
  #   context '未ログインユーザーの場合' do
  #     it 'レスポンスコードが302であること' do
  #       get edit_category_path
  #       expect(response.status).to eq 302
  #     end

  #     it 'サインインページに遷移' do
  #       get edit_category_path
  #       expect(response).to redirect_to "/accounts/sign_in"
  #     end
  #   end

  #   context 'ログインユーザーの場合' do
  #     before do
  #       account = FactoryBot.create(:account)
  #       login_as(account) 
  #     end

  #     it 'レスポンスコードが200であること' do
  #       get edit_category_path
  #       expect(response.status).to eq 200
  #     end

  #     after do
  #       logout(@account)
  #     end
  #   end
  # end
end
