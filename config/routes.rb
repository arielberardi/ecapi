Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
  end

  post '/index', to: 'application#index', defaults: {format: :json}
end
