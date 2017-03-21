Rails.application.routes.draw do
  resources :employees
  resources :purchase_bills
  resources :providers
  resources :services
  resources :contracts
  resources :clients
  resources :materials
  resources :movement_details
  resources :material_movements
  root to: 'welcome#index'
  get 'welcome/index'
  devise_for :users
  resources :users
end
