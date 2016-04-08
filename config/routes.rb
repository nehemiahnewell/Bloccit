Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
  end
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end
  resources :labels, only: [:show]
    
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :favorites, only: [:create, :destroy]
  
  get 'about' => 'welcome#about'
  root 'welcome#index'
end