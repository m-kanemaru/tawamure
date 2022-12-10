class Publics::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    @post.score = Language.get_data(post_params[:text])
    
    if @post.save
      
      if @post.image_id.present?
        tags = Vision.get_image_data(@post.image_id)
        tags.each do |tag|
          @post.tags.create(name: tag)
        end
      end
      
      redirect_to post_path(@post),notice:"投稿成功"
    else
      render :new
    end
  end

  def index
    @posts = Post.where(user_id: [*current_user.following_ids,current_user.id]).page(params[:page])
    @user = current_user
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
    @old_tags = Tag.joins(:post).where(post_id: @post.id)
    
    @old_tags.each do |tag|
      tag.destroy
    end
    
    if @post.update(post_params)
        
      if @post.image_id.present?
        tags = Vision.get_image_data(@post.image_id)
        tags.each do |tag|
          @post.tags.create(name: tag)
        end
      end
      
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
  
  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user_id == current_user
      redirect_to posts_path
    end
  end
  
end
