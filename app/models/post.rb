class Post < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
  validates :body, length: { in: 0..100 }
  mount_uploader :image, ImageUploader
end
