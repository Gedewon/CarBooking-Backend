# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :cars
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post "auth/sign_up", to: "registrations#create"
      resources :cars
    end
  end
end
