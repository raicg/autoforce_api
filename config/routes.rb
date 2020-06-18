Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :orders, only: [:index, :show, :create]
      jsonapi_resources :batches, only: [:index, :show, :create] do
        member do
          post :close_orders
          post :send_orders
        end
      end
    end
  end
end
