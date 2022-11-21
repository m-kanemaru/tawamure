class Post < ApplicationRecord
    validates :text,presence:true,length:{maximum:200}

    belongs_to :user
    has_many :post_favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    has_many :tags, dependent: :destroy
    
    def create_notification_comment!(current_user, post_comment_id)
        temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
        temp_ids.each do |temp_id|
            save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
        end
        save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
    end

    def save_notification_comment!(current_user, post_comment_id, visited_id)
        notification = current_user.active_notifications.new(
            post_id: id,
            post_comment_id: post_comment_id,
            visited_id: visited_id,
            action: 'comment'
        )
        if notification.visiter_id == notification.visited_id
            notification.checked = true
        end
        notification.save
        if notification.valid?
        end
    end
    
     has_one_attached :image_id
    
    def favorited_by?(user)
        post_favorites.exists?(user_id: user.id)
    end
    
    def self.looks(word)
        @post = Post.where("text LIKE?","%#{word}%")
    end
end
