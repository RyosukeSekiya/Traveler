class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
 
  validates :image, presence: true
  validates :body, length: { in: 0..100 }
  mount_uploader :image, ImageUploader
end
