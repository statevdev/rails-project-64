Rails.application.routes.draw do
  root 'posts#index'
  # resources :users
  devise_for :users

  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :posts
end
