require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'

  mount Sidekiq::Web, at: '/sidekiq'

  resources :posts, only: [:create]
end
