class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews
  has_many :restaurants, through: :reviews
  has_many :comments
  has_many :restaurants, through: :comments
  has_many :favorites
  has_many :restaurants, through: :favorites

  validates :email, uniqueness: true
end
