require 'rails_helper'

describe 'api/v1/registrations_controller', type: :request do

  context 'When creating a new user' do
    before do
      @user = create(:user)
      post '/api/signup', params: {
        user: {
          name: @user.name,
          email: @user.email,
          password: @user.password,
          password_confirmation: @user.password,
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns a token' do
      p response.headers
      expect(response.headers['Authorization']).to be_present
    end
  end
end