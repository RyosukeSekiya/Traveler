class PostsController < ApplicationController
  before_action :set_post, only: %i[show update edit destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: %i[destroy]
  
  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end
  
  
  def new
    @post = current_user.posts.build
  end

  def show; end
  
  def edit; end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
        redirect_to root_path, notice:'写真を投稿しました。'
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
    @post.destroy
    redirect_to root_path, notice: '投稿を削除しました。'
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
