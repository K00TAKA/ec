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
  
  namespace :customers do
    resources :items, :cart_items, :orders, :order_details, :addresses
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
