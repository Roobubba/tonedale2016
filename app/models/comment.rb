class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo

  validates :user_id, presence: true
  validates :photo_id, presence: true
  validates :body, presence: true, length: { minimum: 3, maximum: 250 }
  default_scope -> { order(updated_at: :desc) }
  
  #validates_uniqueness_of :user, scope: :photo

end
