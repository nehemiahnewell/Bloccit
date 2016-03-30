Rails.application.routes.draw do

resources :posts, :topics

get 'about' => 'welcome#about'
root 'welcome#index'

end