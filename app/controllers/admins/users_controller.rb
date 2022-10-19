class Admins::UsersController < ApplicationController
    layout "admin_application"
    def index
        @users = User.all
    end
    
    def show
      @user = User.find(params[:id])
      @posts = @user.posts
    end
    
    def edit
      @user = User.find(params[:id])
    end
    
    def withdrawal
      @user = User.find(params[:id])
      @user.update(is_deleted: true)
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to root_path
    end
end
