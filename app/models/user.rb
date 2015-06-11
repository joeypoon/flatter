class User < ActiveRecord::Base

  has_many :posts
  has_secure_password
  acts_as_follower
  acts_as_followable

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

end
