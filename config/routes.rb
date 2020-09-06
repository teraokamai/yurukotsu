Rails.application.routes.draw do
  root 'records#index'
  get 'records/index'
  get 'records', to: 'records#index'
  get 'records/edit'
  devise_for :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
