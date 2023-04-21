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
  
end
