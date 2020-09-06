Rails.application.routes.draw do
  resources :providers do
    get :home, on: :collection
  end
  namespace :api do
    resources :providers
  end
  root 'providers#home'
end
