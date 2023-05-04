class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  has_many :comments
  has_many :users, through: :comments
  has_many :favorites
  has_many :users, through: :favorites

  validates :name, presence: true
  validates :location, presence: true
  
  def self.search(query)
    if query
      self.where("location LIKE ? OR name LIKE ?", "%#{query}%", "%#{query}%")
    else
      @restaurants = Restaurant.all
    end
  end
  
  def self.showUpvote(id)
    @restaurantVotes = Review.where("restaurant_id == ?", id)
    tally = 0
    @restaurantVotes.each do |vote|
      tally = vote.upvote + tally
    end
    tally
  end

  def self.showDownvote(id)
    @restaurantVotes = Review.where("restaurant_id == ?", id)
    tally = 0
    @restaurantVotes.each do |vote|
      tally = vote.downvote + tally
    end
    tally
  end
  
  def self.isFavorite(current_user, id)
    @fave = Favorite.where("user_id == ? AND restaurant_id == ?", current_user, id)
    status = false
    @fave.each do |favorite|
      if favorite.isFavorite
        puts favorite
        status = true
      end
    end
    status
  end
  
end
