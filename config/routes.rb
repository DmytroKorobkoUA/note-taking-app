require 'resque/server'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Resque::Server, at: '/resque'

  namespace :v1 do
    root "index#index"

    resource :auth, controller: :authentication, only: [] do
      post :login, on: :member
    end

    resources :notes, only: %i[index show], shallow: true

    namespace :users do
      resources :notes, only: %i[create update destroy], shallow: true
    end
  end
end
