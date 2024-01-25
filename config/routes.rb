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
  
  # namespaceを使うとURLにpublicが付くためscopeを使用
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get 'customers/check' => 'customers#check'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers, :cart_items, :addresses
    resources :items, only: [:index, :show]
    resources :orders, only: [:index, :new, :create, :show] do
      collection do
        post 'confirm'
        get 'thanks'
      end
    end
  end
  

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
