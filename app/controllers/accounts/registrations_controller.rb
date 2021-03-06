# frozen_string_literal: true

class Accounts::RegistrationsController < Devise::RegistrationsController
  layout 'devise_registrations'
  before_action :check_guest, only: %i[edit destroy]

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super

    return unless current_account

    Category.create(name: 'カテゴリなし', account_id: current_account.id, is_default: 'true')
  end

  def show
    if current_account
      render layout: 'devise_account'
    else
      redirect_to root_path
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    Record.where('account_id = ?', current_account.id).destroy_all
    Category.where('account_id = ?', current_account.id).destroy_all
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def check_guest
    return unless resource.email == 'guest@com'

    flash[:alert] = 'ゲストユーザーの変更・削除はできません。'
    render 'show', layout: 'devise_account'
  end
end
