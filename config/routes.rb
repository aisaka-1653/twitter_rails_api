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
        resource :retweets, only: %i[create destroy], module: 'tweets'
        resource :likes, only: %i[create destroy], module: 'tweets'
      end

      resources :users, only: %i[show] do
        resources :comments, only: %i[index], module: 'users'
        resources :retweets, only: %i[index], module: 'users'
        resources :likes, only: %i[index], module: 'users'
        resource :follow, only: %i[create], module: 'users', controller: 'user_follows'
        resource :unfollow, only: %i[destroy], module: 'users', controller: 'user_follows'
      end

      resources :images
      resources :comments, only: %i[create destroy]
      resource :profile, controller: 'users'
    end
  end
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
