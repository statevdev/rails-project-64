# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en|ru/ do
    root 'posts#index'
    devise_for :users

    resources :posts do
      resources :comments, only: :create
      resources :likes, only: %i[create destroy]
    end
  end
end
