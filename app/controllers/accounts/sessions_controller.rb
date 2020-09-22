# frozen_string_literal: true

class Accounts::SessionsController < Devise::SessionsController
  layout 'devise'
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def new_guest
    account = Account.find_by(email: 'guest@com')
    if !account
      Account.create(password: 'guestuser123', email: 'guest@com')
      account = Account.find_by(email: 'guest@com')
      sign_in account
      Category.create(name: 'カテゴリなし', account_id: current_account.id, is_default: true)
    else
      sign_in account
    end

    redirect_to root_path, notice: 'ゲストユーザーでログインしました。'
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
