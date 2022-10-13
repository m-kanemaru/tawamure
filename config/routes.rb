Rails.application.routes.draw do
  root to:"homes#top"
  
  #public側の設定(chatと通知は未設定)
  scope module: :publics do
    get 'relationships/followings'
    get 'relationships/followers'
    
    devise_for :users
     
    resources :users, only: [:index,:show,:edit,:update]
    
    resources :users do
      resource :relationships, only: [:create, :destroy]
        member do
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
      end
    end
    
    resources :posts, only: [:new, :index,:show,:edit,:create,:destroy,:update] do
      resources :post_favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    
    resources :groups, only: [:new, :index,:show,:edit,:create,:destroy,:update]

  end


  #admin側の設定
  namespace :admins do
  
    devise_for :admins
    
    resources :users, only: [:index,:show,:edit,:update]
    
    resources :posts, only: [:index,:show,:edit,:destroy,:update] do
      resources :post_comments, only: [:destroy]
    end
    
    resources :groups, only: [:index,:show,:edit,:destroy,:update]
    
  
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
