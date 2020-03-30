Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :drivers
      resources :locations, only: [:index, :show]
      resources :trips, only: [:index, :show]
    end
  end
end
