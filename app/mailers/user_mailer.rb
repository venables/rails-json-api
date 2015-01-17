class UserMailer < ActionMailer::Base
  default from: "hello@rails_json_api.com"

  def founder_email(user)
    @user = user
    mail to: user.email, from: "matt@rails_json_api.com"
  end

  def reset_password_email(password_reset)
    @user = password_reset.user
    @token = password_reset.token
    mail to: @user.email
  end

end
