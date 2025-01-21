Rails.application.routes.draw do
  namespace :public do
    get 'groups/new'
    get 'groups/index'
    get 'groups/show'
    get 'groups/edit'
    get 'groups/create'
    get 'groups/update'
    get 'groups/destroy'
  end
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
    get "/search", to: "searches#search"
    get 'members/mypage', to: 'members#mypage'
    resources :members, only: [:index, :show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :create, :edit, :update, :destroy]
    resources :free_posts, only: [:index, :show, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
    resources :groups, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :group_members, only: [:create, :destroy]
    end
  end

  

  namespace :admin do
    root "members#index" 
    get "/search", to: "searches#search"
    resources :members, only: [:index, :show, :destroy]
    resources :free_posts, only: [:index, :show, :destroy]
    resources :groups, only: [:index, :destroy]
    resources :comments, only: [:destroy]
  end
end
