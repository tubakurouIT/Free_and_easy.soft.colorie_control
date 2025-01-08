Rails.application.routes.draw do
  # 顧客用
  # URL /members/sign_in ...
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }




  namespace :public do
    root :to => "homes#top"
    resources :members, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:new, :show, :create, :edit, :update, :destroy]
    resources :comments, only: [:index, :show, :edit, :update, :destroy]
    resources :groups
  end

  namespace :admin do
    root :to => "homes#top"
    resources :members, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :groups, only: [:index, :destroy]
  end
end
