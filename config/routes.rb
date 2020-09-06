Rails.application.routes.draw do
  resources :providers do
    get :search, on: :collection
    get :home, on: :collection
  end
  namespace :api do
    resources :providers do
      collection do
        get :search
      end
    end
  end
  root 'providers#home'
end
