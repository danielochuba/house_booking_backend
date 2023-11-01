Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/auth/login", to: "authentication#login"
      post "/auth/register", to: "authentication#register"

      resources :houses, only: [:create, :index, :show] do
        collection do
          get "find_by_name"
        end
      end

      resources :house_bookings, only: [:index, :create], path: "reservations"
    end
  end
end
