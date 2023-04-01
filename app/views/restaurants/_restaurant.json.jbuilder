json.extract! restaurant, :id, :name, :location, :upvote, :downvote, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
