# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::AuthenticationController, type: :request do
  let(:user) { create :user }

  describe 'POST /v1/auth/login' do
    context 'with correct params' do
      it 'returns token' do
        post login_v1_auth_path, params: { username: user.username, password: 'StrongPassword' }

        expect(response).to have_http_status(:ok)
        expect(json_response[:token]).to_not eq(nil)
        expect { JWT.decode(json_response[:token], key) }.to_not raise_error(JWT::DecodeError)
      end
    end

    context 'with incorrect params' do
      before { post login_v1_auth_path, params: { username: user.username, password: 'WrongPassword' } }

      it 'returns http status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
        expect(json_response[:error]).to include 'Unauthorized'
      end
    end
  end
end
