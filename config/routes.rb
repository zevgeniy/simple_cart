Rails.application.routes.draw do
  namespace :simple_cart do
    resource :cart, only: [:show, :update]
    resources :cart_items, only: [:create, :destroy]
  end
end