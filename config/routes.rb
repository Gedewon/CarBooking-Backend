# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      devise_for :users, controllers: { sessions: :sessions },
                       path_names: { sign_in: :login }
      resource :user, only: [:show, :update]
    end
  end

end
