# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      get 'auth/imagekit' ,to: 'imagekit#index'
      post 'auth/sign_up', to: 'registrations#create'
      post 'auth/sign_in', to: 'sessions#create'
      delete 'auth/sign_out', to: 'sessions#destroy'
      post 'auth/validate_token', to:'sessions#validate_token'
      resources :reservations
      resources :cars
    end
  end
end
