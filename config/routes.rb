Rails.application.routes.draw do
  Rails.application.routes.draw do
    namespace :api do
      namespace :v1 do
        post "/auth/login", to: "authentication#login"
        post "/auth/register", to: "authentication#register"
      end
    end
  end
end
