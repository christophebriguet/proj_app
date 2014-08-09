class User < ActiveRecord::Base
  
  before_save { email.downcase! }
  
  validates :name, presence: true, length: { maximum: 50 }
  
 #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  after_initialize :defaults

  def defaults
    self.admin = false if self.admin.nil?
  end

  has_secure_password
  
  validates :password, length: { minimum: 6 }
  
end
