class Post < ApplicationRecord
    validates :text,presence:true,length:{maximum:200}

    belongs_to :user
    has_many :post_favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    has_many :tags, dependent: :destroy
    
    has_one_attached :image_id
    
    def favorited_by?(user)
        post_favorites.exists?(user_id: user.id)
    end
    
    def self.looks(word)
        @post = Post.where("text LIKE?","%#{word}%")
    end
    
    
    has_many :notifications, dependent: :destroy
    
    def create_notification_like!(current_user)
        temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ",
                                      current_user.id, user_id, id, 'like'])
        if temp.blank?
            notification = current_user.active_notifications.new(
                post_id: id,
                visited_id: user_id,
                action: 'like'
            )
            
            if notification.visitor_id == notification.visited_id
                notification.checked = true
            end
            notification.save if notification.valid?
        end
    end
    
    def create_notification_comment!(current_user, post_comment_id)
        #同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
        temp_ids = PostComment.where(post_id: id).where.not("user_id=? or user_id=?", current_user.id,user_id).select(:user_id).distinct
        #取得したユーザー達へ通知を作成。（user_idのみ繰り返し取得）
        temp_ids.each do |temp_id|
          save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
        end
        #投稿者へ通知を作成
        save_notification_comment!(current_user, post_comment_id, user_id)
    end

    def save_notification_comment!(current_user, post_comment_id, visited_id)
        notification = current_user.active_notifications.new(
            post_id: id,
            post_comment_id: post_comment_id,
            visited_id: visited_id,
            action: 'comment'
            )
        if notification.visitor_id == notification.visited_id
            notification.checked = true
        end
        notification.save if notification.valid?
    end

    
end
