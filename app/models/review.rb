class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :dish
  validates :body, presence: true
end
