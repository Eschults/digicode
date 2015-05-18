Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "registrations" }
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      post :ask_for_code, to: "users#ask_for_code"
      post :accept_request, to: "users#accept_request"
      post :decline_request, to: "users#decline_request"
    end
  end
end
