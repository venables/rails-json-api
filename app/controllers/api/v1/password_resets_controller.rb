class Api::V1::PasswordResetsController < Api::V1::ApplicationController
  before_filter :prevent_authenticated_user!, only: [:create]
  before_filter :find_password_reset, only: [:update]

  def create
    user = User.where(email: params[:email].try(:downcase)).first

    if user
      password_reset = user.password_resets.new
      if password_reset.save
        UserMailer.reset_password_email(password_reset).deliver_later
      end
    end

    head :created
  end

  def update
    if @password_reset.user.update_attributes(password_reset_params)
      @password_reset.user.sessions.delete_all
      @password_reset.destroy
      head :no_content
    else
      render 'error', status: :bad_request
    end
  end

  private

  def password_reset_params
    params.permit(:password)
  end

  def find_password_reset
    @password_reset = PasswordReset.not_expired.where(token: params[:id]).first

    unless @password_reset
      head :not_found
    end
  end
end
