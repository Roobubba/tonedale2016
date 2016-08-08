class Photo < ActiveRecord::Base
  belongs_to :user
  
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :photo_tags, dependent: :destroy
  has_many :tags, through: :photo_tags
  
  validates :user_id, presence: true
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  
  
  mount_uploader :picture, PictureUploader
  validates :picture, presence: true
  validate :picture_size
  default_scope -> { order(updated_at: :desc) }
  
  def thumbs_up_total
    self.likes.where(like: true).size
  end
  
  def thumbs_down_total
    self.likes.where(like: false).size    
  end
  
  def num_comments
    self.comments.size
  end
  
  def already_commented?(user)
    checkuser = Comment.find_by(user_id: user.id, photo_id: self.id)
    !!checkuser
  end
  
  private
    def picture_size
      if picture.size > 10.megabytes
        errors.add(:picture, "should be less than 10MB")
      end
    end
  
end