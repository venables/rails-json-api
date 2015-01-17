require 'rails_helper'

describe UserMailer, type: :mailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  describe '.founder_email' do
    let(:user) { FactoryGirl.build(:user) }

    it 'delivers the correct email' do
      mail = UserMailer.founder_email(user)

      expect(mail).to deliver_to(user.email)
      expect(mail).to have_subject(I18n.t('user_mailer.founder_email.subject'))
    end
  end

  describe '.reset_password_email' do
    let(:password_reset) { FactoryGirl.build(:password_reset) }

    it 'delivers the correct email' do
      mail = UserMailer.reset_password_email(password_reset)

      expect(mail).to deliver_to(password_reset.user.email)
      expect(mail).to have_subject(I18n.t('user_mailer.reset_password_email.subject'))
    end

  end
end
