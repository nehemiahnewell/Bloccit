Rails.application.routes.draw do
  
  get 'labels/show'

  resources :topics do
    resources :posts, except: [:index]
    resources :comments, only: [:create, :destroy]
  end
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
  end
  resources :labels, only: [:show]
    
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
    
    
  get 'about' => 'welcome#about'
  root 'welcome#index'
end