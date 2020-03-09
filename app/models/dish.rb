class Dish < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
end
