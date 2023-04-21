Rails.application.routes.draw do
  devise_for :users
  resources :restaurants
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "restaurants#index"
  
  put "/increaseUpvote", :to=>"restaurants#increaseUpvote"
  put "/increaseDownvote", :to=>"restaurants#increaseDownvote"
end
