class Post < ApplicationRecord
    validates :text,presence:true,length:{maximum:200}

    belongs_to :user
    has_many :post_favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    
    def favorited_by?(user)
        post_favorites.exists?(user_id: user.id)
    end
    
end
