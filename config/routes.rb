Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :drivers
      resources :locations
      resources :trips
    end
   end
end
