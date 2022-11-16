class SearchesController < ApplicationController
    before_action :authenticate_user!

    def search
        @range = params[:range]
        @word = params[:word]
        if @range == "User"
            @users = User.looks(@word).page(params[:page])
        elsif @range == "Post"
            @posts = Post.looks(@word).page(params[:page])
        elsif @range == "Group"
            @groups = Group.looks(@word).page(params[:page])
        else
            @posts = Post.joins(:tags).where(tags:{name: @word.camelize}).page(params[:page])
        end
    end

end
