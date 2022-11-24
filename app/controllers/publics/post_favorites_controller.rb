class Publics::PostFavoritesController < ApplicationController
     before_action :authenticate_user!
    
    def create
        @post = Post.find(params[:post_id])
        post_favorite = current_user.post_favorites.new(post_id: @post.id)
        post_favorite.save
        
        
        @post.create_notification_like!(current_user)
        respond_to do |format|
            format.html { redirect_back(fallback_location: root_url) }
            format.js
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        post_favorite = current_user.post_favorites.find_by(post_id: @post.id)
        post_favorite.destroy
    end
    
end
