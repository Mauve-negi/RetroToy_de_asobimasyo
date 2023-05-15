Rails.application.routes.draw do
  # namespace :public do
  #   get 'posts/index'
  # end
  
  # ユーザ用
  # URL /users/sign_in ...
  devise_for :user,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    # root to: "users#index"
    root to: "homes#index"
    resources :posts
    resources :users
    get "about"=> 'homes#about'
    get 'posts/index'
    post 'homes/guest_sign_in', to: 'homes#guest_sign_in'
  end
  
  namespace :admin do
    root to: 'users#index'
    resources :users
    # resources :orders, only: [:index, :show, :update]
  end
  
end
