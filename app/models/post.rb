class Post < ActiveRecord::Base

  belongs_to :user
  mount_uploader :photo, PhotoUploader

  validates :content, presence: true, length: { maximum: 120 }

end
