Rails.application.routes.draw do
  resources :contacts, only: [:new, :create]
  resources :visitors, only: [:new, :create]
  root to: 'visitors#new'
  get 'more', to: 'visitors#more'
  get 'more2', to: 'visitors#more2'
end
