require 'rails_helper'

class DummyController < ActionController::Base
  include Authentication
end

describe Authentication, type: :controller do
  let(:controller) { DummyController.new }

  describe '#require_authenticated_user!' do
    context 'while signed in' do
      before do
        allow(controller).to receive_messages(signed_in?: true)
      end

      it 'does not return an error' do
        expect do
          controller.send(:require_authenticated_user!)
        end.not_to raise_error
      end
    end

    context 'while not signed in' do
      before do
        allow(controller).to receive_messages(signed_in?: false)
      end

      it 'raises a 403 error' do
        expect do
          controller.send(:require_authenticated_user!)
        end.to raise_error(DummyController::NotAuthenticatedError)
      end
    end
  end

  describe '#prevent_authenticated_user!' do
    context 'while signed in' do
      before do
        allow(controller).to receive_messages(signed_in?: true)
      end

      it 'returns a :forbidden status' do
        allow(controller).to receive(:head)

        controller.send(:prevent_authenticated_user!)

        expect(controller).to have_received(:head).with(:forbidden)
      end
    end

    context 'while not signed in' do
      before do
        allow(controller).to receive_messages(signed_in?: false)
      end

      it 'does nothing' do
        allow(controller).to receive(:head)

        controller.send(:prevent_authenticated_user!)

        expect(controller).to_not have_received(:head)
      end
    end
  end

  describe '#current_user' do
    let(:session) { FactoryGirl.build(:session) }

    context 'with a valid authentication header and token' do
      before do
        allow(controller).to receive_messages(current_session: session)
      end

      it 'returns the user' do
        expect(controller.current_user).to eq(session.user)
      end
    end

    context 'with an session token' do
      before do
        allow(controller).to receive_messages(current_session: nil)
      end

      it 'returns nil' do
        expect(controller.current_user).to be_nil
      end
    end
  end

  describe '#signed_in?' do
    let(:user) { FactoryGirl.build(:user) }

    it 'returns true if a user is signed in' do
      allow(controller).to receive_messages(current_user: user)

      expect(controller.signed_in?).to be true
    end

    it 'returns false if a user is not signed in' do
      allow(controller).to receive_messages(current_user: nil)

      expect(controller.signed_in?).to be false
    end
  end

  describe '#sign_in' do
    let(:user) { FactoryGirl.create(:user) }

    it 'logs out and sets the current_user session' do
      allow(controller).to receive(:sign_out)
      allow(controller.request).to receive_messages(remote_ip: '10.10.10.10', user_agent: 'Safari')

      expect {
        controller.send(:sign_in, user)
      }.to change(user, :last_login_at)

      expect(controller).to have_received(:sign_out)
      expect(controller.instance_variable_get(:@current_session)).not_to be_nil
    end
  end

  describe '#sign_out' do
    let(:session) { FactoryGirl.build(:session) }

    before do
      controller.instance_variable_set(:@current_session, session)
    end

    it 'clears all traces of being signed in' do
      allow(session).to receive(:destroy)

      controller.send(:sign_out)

      expect(session).to have_received(:destroy)
      expect(controller.instance_variable_get(:@current_session)).to be_nil
    end
  end
end
