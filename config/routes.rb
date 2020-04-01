Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#homepage"
  resources :users

  resources :dishes

  resources :dishes do
    resources :reviews
  end

  get 'plans' => 'subscriptions#plans'
  get 'choose-meals', :to => 'subscriptions#choose_meals'
  post 'add_to_cart/:dish_id' => 'subscriptions#add_to_cart', :as => 'add_to_cart'
  post 'clear_cart' => 'subscriptions#clear_cart'
  post 'remove_from_cart/:dish_id' => 'subscriptions#remove_from_cart', :as => 'remove_from_cart'
  resource :subscription
  delete '/cancel_subscription' => 'subscriptions#destroy'
  get 'on-the-menu' => 'menus#menu', :as => :menu_selections
end
