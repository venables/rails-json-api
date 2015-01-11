class PasswordReset
  include RedisStorage
  include ActiveModel::Serialization

  persists_to_redis :token, value: :user_id, prefix: 'password', unique: true, expires: 3_600

  attr_reader :user
  delegate :id, to: :user, prefix: true

  def initialize(token, user)
    @token = token
    @user = user
  end

  def self.generate_for_user!(user)
    return unless user

    random_token = SecureRandom.urlsafe_base64(32)
    password_reset = PasswordReset.new(random_token, user)

    if password_reset.save
      password_reset
    end
  end

  def self.load_from_token(token_value)
    user_id = get_user_id_from_key(token_value)

    if user = User.where(id: user_id).first
      new(token_value, user)
    end

  rescue
    Rails.logger.error('Session.generate_from_signed_token error')
    nil
  end

  def token
    @token
  end
end
