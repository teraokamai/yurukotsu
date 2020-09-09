Rails.application.routes.draw do
  root "records#index"
  resources :categories
  resources :records
  devise_for :accounts
end
