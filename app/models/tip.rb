class Tip < ActiveRecord::Base
  belongs_to :strategy, touch: true
  validates :content, presence: true

end
