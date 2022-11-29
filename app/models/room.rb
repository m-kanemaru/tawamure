class Room < ApplicationRecord
    has_many :user_rooms
    has_many :chats
    has_many :notifications, dependent: :destroy
    
#   def create_notification_dm!(current_user, chat_id)
#     @multiple_entry_records = Chat.where(room_id: id).where.not(user_id: current_user.id)
#     @single_entry_record = @multiple_entry_records.find_by(room_id: id)
#     notification = current_user.active_notifications.build(
#       room_id: id,
#       chat_id: chat_id,
#       visited_id: @single_entry_record.user_id,
#       action: 'dm'
#     )

#     notification.save if notification.valid?
#   end
  
    # def create_notification_dm!(current_user)
    #     temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ",
    #                                   current_user.id, user_id, id, 'dm'])
    #     if temp.blank?
    #         notification = current_user.active_notifications.new(
    #             chat_id: id,
    #             visited_id: user_id,
    #             action: 'dm'
    #         )
            
    #         if notification.visitor_id == notification.visited_id
    #             notification.checked = true
    #         end
    #         notification.save if notification.valid?
    #     end
    # end
    
    # def create_notification_dm!(current_user, room_id)
    #     # チャットしている相手を取得し、通知を送る
    #     temp_ids = Chat.select(:user_id).where(room_id: room_id).where.not(user_id: current_user.id).distinct
    #     temp_ids.each do |temp_id|
    #         save_notification_chat!(current_user, room_id, temp_id['user_id'])
    #     end
    # end

    # def save_notification_chat!(current_user, room_id, visited_id)
    #     # チャットは複数回することが考えられるため、複数回通知する
    #     notification = current_user.active_notifications.new(
    #         chat_id: id,
    #         room_id: room_id,
    #         visited_id: visited_id,
    #         action: 'dm'
    #     )
    #     # 自分のチャットの場合は、通知済みとする
    #     if notification.visitor_id == notification.visited_id
    #         notification.checked = true
    #     end
    #     notification.save if notification.valid?
    # end
    
 
end
