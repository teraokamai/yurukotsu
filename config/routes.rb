Rails.application.routes.draw do
  root "records#index"
  resources :categories
  resources :records

  devise_scope :account do
    get "accounts" => "accounts/registrations#show"
  end

  devise_for :accounts, :controllers => { :registrations => "accounts/registrations" }
end
