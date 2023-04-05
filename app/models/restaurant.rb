class Restaurant < ApplicationRecord
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
