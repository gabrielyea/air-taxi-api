require 'rails_helper'

describe 'api/v1/registrations_controller', type: :request do

  context 'When creating a new user' do
    before :each do
      @user = create(:user)
      post '/api/signup', params: {
        user: {
          name: 'helohelo',
          email: 'testtest@gmail.com',
          password: '123456',
          password_confirmation: '123456',
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end
    
    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end
  end
end