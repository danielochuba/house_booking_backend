Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/auth/login", to: "authentication#login"
      post "/auth/register", to: "authentication#register"

      resources :houses, only: [:create]

    end
  end
end
