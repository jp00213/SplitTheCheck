Rails.application.routes.draw do
  devise_for :users
  resources :restaurants
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "restaurants#index"
  
  put "/summary", :to=>"restaurants#summary"
  get "/summary", :to=>"restaurants#summary"
  put "/increaseUpvote", :to=>"restaurants#increaseUpvote"
  put "/increaseDownvote", :to=>"restaurants#increaseDownvote"
  
  get "/newComment", :to=>"restaurants#newComment"
  post "/newComment", :to=>"restaurants#addComment"
end
