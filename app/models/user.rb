class User < ApplicationRecord
  validates :username, :session_token, :password_digest, uniqueness: true
  validates :username, :session_token, :password_digest, presence: true
  
  attr_reader :password

  after_initialize :ensure_session_token

  has_many :cats,
  class_name: 'Cat',
  foreign_key: :user_id,
  primary_key: :id,
  dependent: :destroy

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user.is_password?(password)
    nil
  end

  def ensure_session_token
    self.session_token ||= self.generate_session_token
  end

  def generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def owns_cat?(cat)
    cat.user_id == self.id
  end
  


end
