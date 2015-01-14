class DeleteExpiredRecords < ActiveJob::Base
  queue_as :expire_records

  def perform
    Session.where('sessions.expires_at <= ?', Time.now).delete_all
    PasswordReset.where('password_resets.expires_at <= ?', Time.now).delete_all
  end
end
