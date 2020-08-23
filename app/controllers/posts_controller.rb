class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  
  def index
    @posts = Post.all
  end

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
      redirect_to root_path, notice: '写真を投稿しました。'
    else
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
      @post = Post.find_by(id:params[:id])
    end

    def post_params
      params.require(:post).permit(:image, :body)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      unless @post
        redirect_to root_path
      end
    end
end
