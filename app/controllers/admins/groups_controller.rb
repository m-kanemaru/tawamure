class Admins::GroupsController < ApplicationController
 layout "admin_application"
 def index
    @groups = Group.all
 end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
  end
  
  def all_destroy
    @group = Group.find(params[:group_id])
    @group.destroy
    redirect_to admins_groups_path
  end  

end
