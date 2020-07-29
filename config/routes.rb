Rails.application.routes.draw do
  root to: 'home#index'
  get '/searches', to: 'home#index'

  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :searches, only: [:index]
    end
  end
end
