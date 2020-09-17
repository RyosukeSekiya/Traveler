class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit likes]
  
  def show
    @posts = @user.posts.order(id: :desc).page(params[:page])
  end

  def edit; end

  def likes
    @likes = @user.favorites.page(params[:page])
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password, :image)
  end
end
