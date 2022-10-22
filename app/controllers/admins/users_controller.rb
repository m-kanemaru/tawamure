class Admins::UsersController < ApplicationController
    before_action :authenticate_admin!
    before_action :ensure_customer, only: [:show, :update]
    layout "admin_application"
    def index
        @users = User.all
    end
    
    def show
      @user = User.find(params[:id])
      @posts = @user.posts
    end
    
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admins_user_path(@user), notice: "You have updated user successfully."
      else
        render 'index'
      end
    end
    
    def withdrawal
      @user = User.find(params[:id])
      @user.update(is_deleted: true)
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to root_path
    end
    
    def user_params
      params.require(:user).permit(:is_deleted)
    end
  
    def ensure_customer
      @user = User.find(params[:id])
    end
end
