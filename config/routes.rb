Rails.application.routes.draw do
  # 顧客用　URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  # 管理者用　URL /admin/sign_in ...
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    resources :items, :genres, :customers, :orders, :order_details
  end
  
  root to: 'public/homes#top'
  get "about" => "public/homes#about"
  resources :customers
  resources :items
  resources :cart_items
  resources :orders
  resources :order_details
  resources :addresses

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
