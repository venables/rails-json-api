class Session
  include SignedValue

  TTL = 3_600 # 1 hour

  has_signed_value :token

  attr_reader :user

  def initialize(token, user)
    @token = token
    @user = user
  end

  def self.generate_for_user!(user)
    random_token = SecureRandom.uuid.gsub('-', '')
    session = Session.new(random_token, user)

    if session.save
      session
    end
  end

  def self.generate_from_signed_token(signed_token)
    token_value = token_from_signed_token(signed_token)
    user_id = Redis.current.get(redis_key_for_token(token_value))

    if user = User.find(user_id)
      session = Session.new(token_value, user)
      session.extend
      session
    end

  rescue
    Rails.logger.error('Session.generate_from_signed_token error')
    nil
  end

  def save
    Redis.current.setex(redis_key, TTL, redis_value)
  end

  def extend
    Redis.current.expire(redis_key, TTL)
  end

  def destroy
    Redis.current.del(redis_key)
    @token = nil
    @user = nil
  end

  private

  def token
    @token
  end

  def self.redis_key_for_token(token)
    'session:' + token
  end

  def redis_key
    Session.redis_key_for_token(@token)
  end

  def redis_value
    self.user.id
  end
end
