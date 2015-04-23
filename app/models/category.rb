class Category < ActiveRecord::Base
  has_and_belongs_to_many :strategies
  validates :category_name, presence: true
  validates :category_name, uniqueness: true
end
