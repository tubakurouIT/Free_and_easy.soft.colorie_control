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

  devise_scope :member do
    post "members/guest_sign_in", to: "members/sessions#guest_sign_in"
  end


  scope module: :public do
    root to: "homes#top"

    get 'members/mypage', to: 'members#mypage'
    resources :members, only: [:show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :create, :edit, :update, :destroy]
    resources :free_posts, only: [:index, :show, :create, :edit, :update, :destroy]
    resources :groups, only: [:index, :show, :create, :edit, :update, :destroy]
  end

  namespace :admin do
    root to: "homes#top"
    resources :members, only: [:index, :show, :destroy]
    resources :free_posts, only: [:index, :show, :destroy]
    resources :groups, only: [:index, :destroy]
  end
end
