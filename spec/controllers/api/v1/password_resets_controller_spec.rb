require 'rails_helper'

describe Api::V1::PasswordResetsController, type: :controller do
  let(:default_params) { { format: :json } }

  describe '#create' do
    let(:email) { double('email', deliver: {}) }

    context 'using an invalid email address' do
      it 'does not inform the user that the email address was not found' do
        post :create, { email: 'invalid email' }

        expect(response).to have_http_status(:created)
      end
    end

    context 'using a valid email address' do
      let(:user) { FactoryGirl.create(:user) }

      it 'sends the password reset instructions to a user' do
        email = double('email', deliver_later: true)
        allow(UserMailer).to receive(:reset_password_email).and_return(email)

        post :create, { email: user.email }

        expect(UserMailer).to have_received(:reset_password_email)
        expect(email).to have_received(:deliver_later)
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe '#update' do
    context 'with an invalid token' do
      it 'redirects to the homepage' do
        put :update, id: 'an invalid token'

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with a valid token' do
      let(:user) { FactoryGirl.create(:user) }
      let(:password_reset) { FactoryGirl.create(:password_reset, user: user) }

      context 'with bad passwords' do
        it 'throws an error if passwords are not valid' do
          allow_any_instance_of(User).to receive_messages(update_attributes: false)

          put :update, id: password_reset.token, password: '1'

          expect(response).to render_template('error')
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'with valid passwords' do
        it 'changes the password and redirect to the sign-in screen' do
          put :update, id: password_reset.token, password: 'new-password'

          expect(response).to have_http_status(:no_content)
        end
      end
    end
  end
end
