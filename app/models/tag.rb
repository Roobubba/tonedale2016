class Tag < ActiveRecord::Base
  
  has_many :photo_tags
  has_many :photos, through: :photo_tags
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  
end