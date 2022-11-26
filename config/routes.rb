# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # create sessino's
      post 'auth/sign_up', to: 'registrations#create'
      post 'auth/sign_in', to: 'sessions#create'
      delete 'auth/sign_out', to: 'sessions#destroy'
      resources :reservations
      resources :cars
    end
  end
end
