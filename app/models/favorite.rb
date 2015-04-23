class Favorite < ActiveRecord::Base
  belongs_to :user
  #belongs_to :strategy
  has_many :strategies, through: :users
end
