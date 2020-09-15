Rails.application.routes.draw do
  root "records#index"
  resources :categories
  resources :records

  devise_scope :account do
    get "accounts/show" => "accounts/registrations#show"
    get "accounts" => "accounts/registrations#new"
    post "accounts/guest_sign_in", to: "accounts/sessions#new_guest"
  end

  devise_for :accounts, :controllers => {
                          :registrations => "accounts/registrations",
                          :sessions => "accounts/sessions",
                        }
end
