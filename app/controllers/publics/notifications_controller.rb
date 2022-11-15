class Publics::NotificationsController < ApplicationController
    def index
        @notifications = current_user.passive_notifications.page(params[:page]).per(7)
    end
    
    def update
        notification = Notification.find(params[:id])
        notification.update_attributes(checked: true)
        redirect_to request.referer
    end
end
