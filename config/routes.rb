Rails.application.routes.draw do
  resources :restaurants
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  put "/increaseUpvote", :to=>"restaurants#increaseUpvote"
  put "/increaseDownvote", :to=>"restaurants#increaseDownvote"

end
