Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: :json} do
    devise_scope :user do
      post 'sign_up',         to: 'registrations#create'
      post 'sign_in',         to: 'sessions#create'
      delete 'sign_out',      to: 'sessions#destroy'
      post 'confirmation',    to: 'confirmations#show'
      post 'password/edit',   to: 'registrations#update'
      post 'password/forgot', to: 'passwords#create'
      post 'password/reset',  to: 'passwords#update'
      post 'unlock/create',   to: 'unlocks#create'
      post 'unlock/reset',    to: 'unlocks#show'
    end

    resources :shopping_carts
    resources :products
    resources :categories
    resources :subcategories
  end 

  post '/index', to: 'home#index', defaults: {format: :json}
end