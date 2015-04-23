class Author < ActiveRecord::Base
  has_and_belongs_to_many :strategies

  has_attached_file :image, styles: { medium: "300x300>", thumb: "150x150>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :image_file_name, presence: true
  validates :name, presence: true
  validates :bio, presence: true
end
