class Session < ActiveRecord::Base
  include SecureToken
  include SignedValue

  TTL = 1.hour

  belongs_to :user

  has_secure_token :token, length: 32
  has_signed_value :token

  validates :user_id, presence: true
  validates :token, uniqueness: true

  before_save do
    self.expires_at = Time.now + TTL
  end

  def self.not_expired
    where('sessions.expires_at >= ?', Time.now)
  end
end
