class Session
  include RedisStorage
  include SignedValue

  persists_to_redis :token, value: :user_id, prefix: 'session', unique: true, expires: 3_600
  has_signed_value :token

  attr_reader :user
  delegate :id, to: :user, prefix: true

  def initialize(token, user)
    @token = token
    @user = user
  end

  def self.generate_for_user!(user)
    random_token = SecureRandom.urlsafe_base64(32)
    session = Session.new(random_token, user)

    if session.save
      session
    end
  end

  def self.generate_from_signed_token(signed_token)
    token_value = token_from_signed_token(signed_token)
    user_id = find(token_value)

    if user = User.find(user_id)
      session = Session.new(token_value, user)
      session.renew
      session
    end

  rescue
    Rails.logger.error('Session.generate_from_signed_token error')
    nil
  end


  private

  def token
    @token
  end
end
