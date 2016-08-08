class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  
  validates_uniqueness_of :user, scope: :photo
end