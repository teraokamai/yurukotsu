Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/new'
  root "records#index"
  # get 'records/index'
  # get 'records', to: 'records#index'
  # get 'records/edit'
  resources :records
  devise_for :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
