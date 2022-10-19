class Publics::PostsController < ApplicationController
  before_action :authenticate_user!
  #before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post),notice:"投稿成功"
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post),notice:"投稿成功"
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:text, :image_id)
  end
  
  # def ensure_correct_user
  #   @post = Post.find(params[:id])
  #   unless @Post.user == current_user
  #     redirect_to posts_path
  #   end
  # end
  
end
