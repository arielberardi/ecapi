Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    post 'api/sign_up', to: 'registrations#create', defaults: {format: :json}
    post 'api/sign_in', to: 'sessions#create', defaults: {format: :json}
  end

  namespace :api, defaults: {format: :json} do

  end


  post '/index', to: 'home#index', defaults: {format: :json}
end
