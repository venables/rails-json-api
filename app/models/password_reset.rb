class PasswordReset < ActiveRecord::Base
  include SecureToken

  TTL = 1.hour

  belongs_to :user

  has_secure_token :token, length: 32

  validates :user_id, presence: true
  validates :token, uniqueness: true

  before_save do
    self.expires_at = Time.now + TTL
  end

  before_create do
    user.password_resets.delete_all
  end

  def self.not_expired
    where('password_resets.expires_at >= ?', Time.now)
  end
end
