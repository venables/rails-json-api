class UserMailer < ActionMailer::Base
  default from: "hello@beaker.com"

  def founder_email(user)
    @user = user
    mail to: user.email, from: "matt@beaker.com"
  end

  def reset_password_email(user, token)
    @user = user
    @token = token
    mail to: user.email
  end

end
