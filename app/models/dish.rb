class Dish < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  has_many :reviews
  has_many :users, through: :reviews
  has_many :menus
end
