FactoryGirl.define do
  factory :session do
    user
    token { SecureRandom.urlsafe_base64(32) }
    expires_at { Time.now + Session::TTL }
    ip_address '10.10.10.10'
    user_agent 'Safari'
  end

end
