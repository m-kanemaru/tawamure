class Post < ApplicationRecord
    validates :text,presence:true,length:{maximum:200}

    belongs_to :user
    has_many :post_favorites, dependent: :destroy
    has_many :post_comments, dependent: :destroy
    
     has_many_attached :image_id
    
    def favorited_by?(user)
        post_favorites.exists?(user_id: user.id)
    end
    
    def self.looks(search, word)
        if search == "perfect_match"
            @post = Post.where("title LIKE?","#{word}")
        elsif search == "forward_match"
            @post = Post.where("title LIKE?","#{word}%")
        elsif search == "backward_match"
            @post = Post.where("title LIKE?","%#{word}")
        elsif search == "partial_match"
            @post = Post.where("title LIKE?","%#{word}%")
        else
            @post = Post.all
        end
    end
end
