class Group < ApplicationRecord
    has_many :user_groups
    has_many :users, through: :user_groups
    
    has_one_attached :image_id
    
    def get_image_id
        (image_id.attached?) ? image_id : 'no_image.jpg'
    end

    validates :title, presence: true
    validates :introduction, presence: true
end
