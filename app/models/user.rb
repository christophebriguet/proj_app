class User < ActiveRecord::Base
  
  has_many :microposts, dependent: :destroy
  
  before_save { email.downcase! }
  before_create :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  
 #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  after_initialize :defaults

  def defaults
    self.admin = false if self.admin.nil?
  end
  
  scope :admin, -> { where(admin: true) }
  scope :not_admin, -> { where(admin: false) }
  
  has_secure_password
  
  validates :password, length: { minimum: 6 }
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end  

  def send_password_reset
    self.password_reset_token = User.digest(User.new_remember_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end
  
  
  private
  
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
