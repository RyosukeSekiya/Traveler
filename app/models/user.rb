class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # def show
  # end

  # def edit
  # end

  mount_uploader :image, ImageUploader
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # private
  # #ストロングパラメーター
  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduce, :image )
  # end
end
