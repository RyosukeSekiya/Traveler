class UsersController < ApplicationController
  before_action :authenticate_user!
  
  # def index
  # end

  def show
    @user = User.find(params[:id])
  end

  # def new
  # end

  # def create
  # end

  def edit
    @user = User.find(params[:id])
  end

  # def update
  # end

  # def destroy
  # end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password, :image)
  end
end
