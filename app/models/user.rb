class User < ApplicationRecord
  validates :username, :session_token, :password_digest, uniqueness: true
  validates :username, :session_token, :password_digest, presence: true
  
  attr_reader :password

  after_initialize :ensure_session_token # need to write this

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user.is_password?(password)
    nil
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    Bcrypt::Password.new(self.password_digest).is_password?(password)
  end
  


end
