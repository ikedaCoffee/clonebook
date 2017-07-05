Rails.application.routes.draw do
  resources :topics, only: [:index, :new, :create, :edit, :update, :destroy]
  root 'topics#index'
end
