Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/auth/login", to: "authentication#login"
      post "/auth/register", to: "authentication#register"

      resources :houses, only: [:create, :index, :show, :destroy] do
        collection do
          get "find_by_name"
        end
        get "delete_houses", on: :member
      end

      get "/delete_houses", to: "houses#delete_houses"

      resources :house_bookings, only: [:index, :create], path: "reservations"
    end
  end
end
