class Post < ActiveRecord::Base

  belongs_to :user
  mount_uploader :photo, PhotoUploader

  validates :content, presence: true, length: { maximum: 140 }

  def self.search(search)
    if (search.present?)
      where("content like ?", "%#{search}%").all
    else
      all
    end
  end

end
