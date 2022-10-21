class ChangeChatRoomToUserRoom < ActiveRecord::Migration[6.1]
  def change
    rename_table :chat_rooms, :user_rooms
  end
end
