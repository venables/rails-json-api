FactoryGirl.define do
  factory :password_reset do
    user
    token { SecureRandom.urlsafe_base64(32) }
    expires_at { Time.now + PasswordReset::TTL }
  end

end
