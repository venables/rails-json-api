module SignedValue
  extend ActiveSupport::Concern

  module ClassMethods
    def has_signed_value(attribute = :token, signing_key = nil)
      signing_key ||= Rails.application.secrets.secret_key_base

      define_singleton_method "#{attribute}_from_signed_#{attribute}" do |signed_string|
        JWT.decode(signed_string, signing_key, 'HS512')[0]
      end

      define_method "signed_#{attribute}" do
        JWT.encode(self.send(attribute), signing_key, 'HS512')
      end
    end

  end
end
