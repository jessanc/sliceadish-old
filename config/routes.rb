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

  get 'pricing' => 'subscriptions#pricing'
  get 'pick-your-meals', :to => 'subscriptions#complete', as: 'complete'
  resource :subscription
end
