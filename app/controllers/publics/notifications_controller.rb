class Publics::NotificationsController < ApplicationController
    def index
        @notifications = current_user.passive_notifications.page(params[:page])
        #通知画面を開くとcheckedをtrueにして通知確認済にする
        # @notifications.where(checked: false).each do |notification|
        #   notification.update(checked: true)
        # end
        
    end
    
    def all_update
        @notifications = current_user.passive_notifications
        #通知画面を開くとcheckedをtrueにして通知確認済にする
        @notifications.where(checked: false).each do |notification|
          notification.update(checked: true)
        end
        redirect_to notifications_path
    end
    
    def update
        notification = Notification.find(params[:id])
        notification.update(checked: true)
        redirect_to request.referer
    end
    
    def destroy
        @notifications = current_user.passive_notifications.destroy_all
        redirect_to notifications_path
    end
end
