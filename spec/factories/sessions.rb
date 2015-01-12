FactoryGirl.define do
  factory :session do
    user
    token { SecureRandom.urlsafe_base64(32) }

    initialize_with { new(token, user) }
  end
end
