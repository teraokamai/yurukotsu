Rails.application.routes.draw do
  root "records#index"
  resources :categories
  resources :records
  devise_for :accounts
  devise_scope :account do
    get "accounts" => "accounts/registrations#show"
  end
end
