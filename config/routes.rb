# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :auth do
        resources :sessions, only: %i[index]
      end
      mount_devise_token_auth_for 'User', at: 'users'

      resources :tweets do
        resources :comments, only: %i[index], module: 'tweets'
      end

      resources :users, only: %i[show] do
        resources :comments, only: %i[index], module: 'users'
      end

      resources :images
      resources :comments, only: %i[create destroy]
      # resources :users, only: %i[show]
      resource :profile, controller: 'users'
    end
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
