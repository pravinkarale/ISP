Rails.application.routes.draw do
  resources :providers
  namespace :api do
    resources :providers, only: [], defaults: {format: :json} do
      collection do
        get :sort
        get :search
      end
    end
  end
end
