Rails.application.routes.draw do
  root to:"homes#top"
  get "search" => "searches#search"
  
  #public側の設定(chatと通知は未設定)
  scope module: :publics do
    
    devise_for :users
    
    resources :users, only: [:index,:show,:edit,:update] do
      get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
      patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
      resource :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
    end
    
    resources :posts, only: [:new, :index,:show,:edit,:create,:destroy,:update] do
      resource :post_favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    
    resources :groups, only: [:new, :index,:show,:edit,:create,:destroy,:update] do
      get "join" => "groups#join"
      delete "all_destroy" => 'groups#all_destroy'
    end
    
    get 'chat/:id' => 'chats#show', as: 'chat'
    resources :chats, only: [:create]
    
    resources :notifications, only: [:index, :update] do
      patch "all_update" => 'notifications#all_update'
    end
    
  end


  #admin側の設定
  devise_for :admins, only: [:sessions, :password], :controllers => {
    :sessions => 'admins/sessions'
  }
  
  namespace :admins do
    
    resources :users, only: [:index,:show,:edit,:update]
    
    resources :posts, only: [:index,:show,:edit,:destroy,:update] do
      resources :post_comments, only: [:destroy]
    end
    
    resources :groups, only: [:index,:show,:edit,:destroy,:update]
    
    resources :groups, only: [:new, :index,:show,:edit,:create,:destroy,:update] do
      delete "all_destroy" => 'groups#all_destroy'
    end
  
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
