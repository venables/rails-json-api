module RedisStorage
  extend ActiveSupport::Concern

  module ClassMethods
    def persists_to_redis(attribute, opts = {})
      prefix = opts[:prefix].present? ? "#{opts[:prefix]}:" : ''

      define_singleton_method :find do |key|
        redis_key = prefix + key
        Redis.current.get(redis_key)
      end

      define_method :save do
        redis_key = prefix + self.send(attribute)
        redis_value = opts[:value] ? self.send(opts[:value]) : '1'
        redis_opts = { ex: opts[:expires], nx: opts[:unique] }

        Redis.current.set(redis_key, redis_value, redis_opts)
      end

      define_method :renew do
        redis_key = prefix + self.send(attribute)
        Redis.current.expire(redis_key, opts[:expires])
      end

      define_method :destroy do
        redis_key = prefix + self.send(attribute)
        Redis.current.del(redis_key)
      end
    end
  end
end
