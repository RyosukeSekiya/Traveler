class User < ApplicationRecord
  before_save { self.email.downcase!}
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length:{ maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  mount_uploader :image, ImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy
  
  has_many :favorites, through: :likes, source: :post

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
  
  def like(post)
    likes.find_or_create_by(post_id: post.id)
  end
  
  def unlike(post)
    like = likes.find_by(post_id: post.id)
    like.destroy if like
  end
  
  def favorite?(post)
    favorites.include?(post)
  end
end
