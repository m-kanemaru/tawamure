class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :image_id
  
  def get_image_id
    (image_id.attached?) ? image_id : 'no_image.jpg'
  end
  validates :nickname, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  has_many :posts, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  has_many :user_groups
  has_many :groups, through: :user_groups,dependent: :destroy
  has_many :user_rooms
  
  has_many :chats
  
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_many :active_notifications, foreign_key:"visitor_id", class_name: "Notification", dependent: :destroy
  has_many :passive_notifications, foreign_key:"visited_id", class_name: "Notification", dependent: :destroy
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  def self.looks(word)
    @user = User.where("name LIKE?","%#{word}%")
  end
  
  def create_notification_follow!(current_user)
    #すでに通知が作成されているか確認
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  
  
end
