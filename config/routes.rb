Rails.application.routes.draw do
  get 'pages/home'
  resources :addresses
  resources :neighborhoods
  resources :cities
  resources :states
  resources :order_services do
    collection do
      get 'update_status'
      get 'print_os'
    end
  end
  devise_for :admins
  devise_for :users
  root 'home#index'
  resources :users, :except => [:edit, :destroy, :show, :index]
  get "my_config" => "users#edit"
  get "home" => "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
