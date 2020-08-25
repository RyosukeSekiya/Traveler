class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.favorites.page(params[:page])
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password, :image)
  end
end
