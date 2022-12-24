class Publics::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    
    @user.create_notification_follow!(current_user)
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_url)}
      format.js 
    end
  end
  
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
  end
  
  def followings
    @user = User.find(params[:user_id])
		@users = @user.followings.page(params[:page])
  end

  def followers
    
    @user = User.find(params[:user_id])
		@users = @user.followers.page(params[:page])
  end
end
