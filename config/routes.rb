Rails.application.routes.draw do
  resources :labels
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :destroy]
  root "tasks#index"
  namespace :admin do
    resources :users
  end
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
