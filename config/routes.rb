Rails.application.routes.draw do
  root "static_pages#home"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  namespace :admin do
    resources :categories
    resources :csv, :words
  end
  resources :users do
    member do
      resources :followers
      resources :followings
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :lessons, :categories, :words, :activities
  get "/:page", to: "static_pages#show"
end
