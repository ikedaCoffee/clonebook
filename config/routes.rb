Rails.application.routes.draw do
  devise_for :users
  resources :topics, only: [:index, :new, :create, :edit, :update, :destroy]
  root 'topics#index'
end
