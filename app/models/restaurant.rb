class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews

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

  
end
