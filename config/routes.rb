Rails.application.routes.draw do
  resources :categories
  resources :records
  devise_for :accounts
end
