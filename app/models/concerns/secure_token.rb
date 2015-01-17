# Adapted from Rails' has_secure_token, but improved for more length
# https://github.com/rails/rails/blob/master/activerecord/lib/active_record/secure_token.rb
module SecureToken
  extend ActiveSupport::Concern

  module ClassMethods
    # Example using has_secure_token
    #
    #   # Schema: User(token:string, auth_token:string)
    #   class User < ActiveRecord::Base
    #     has_secure_token
    #     has_secure_token :auth_token, length: 32
    #   end
    #
    #   user = User.new
    #   user.save
    #   user.token # => "4kUgL2pdQMSCQtjE"
    #   user.auth_token # => "77TMHrHJFvFDwodq8w7Ev2m7"
    #   user.regenerate_token # => true
    #   user.regenerate_auth_token # => true
    #
    # SecureRandom::urlsafe_base64 is used to generate the 24-character unique token, so collisions
    # are highly unlikely.
    #
    # Note that it's still possible to generate a race condition in the database in the same way that
    # validates_presence_of can. You're encouraged to add a unique index in the database to deal with
    # this even more unlikely scenario.
    def has_secure_token(attribute = :token, opts={})
      define_method("regenerate_#{attribute}") do
        update!(attribute => self.class.generate_unique_secure_token(opts[:length]))
      end

      before_create do
        self.send("#{attribute}=", self.class.generate_unique_secure_token(opts[:length]))
      end
    end

    def generate_unique_secure_token(length=32)
      SecureRandom.urlsafe_base64(length)
    end

  end
end
