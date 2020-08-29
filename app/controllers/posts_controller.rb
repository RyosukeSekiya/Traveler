class PostsController < ApplicationController
  before_action :set_post, only: [:show,:update,:edit,:destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  
  def new
    @post = current_user.posts.build
  end

  def show
  end
  
  def edit
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
        flash[:success] = '写真を投稿しました。'
        redirect_to root_path
    else
        flash.now[:danger] = '写真の投稿に失敗しました。'
        render :new
    end
  end
  
  def update
    if @post.update(post_params)
      redirect_to @post, notice: '投稿を編集しました。'
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_back(fallback_location: root_path)
      flash[:notice] = '投稿を削除しました。'
    end
  end

  private
  def set_post
    # TODO, 自分のpostだけを修正できるようにした方が良い。
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :body)
  end
  
  def correct_user
    redirect_to root_path unless current_user.posts.find(params[:id])
  end
end
