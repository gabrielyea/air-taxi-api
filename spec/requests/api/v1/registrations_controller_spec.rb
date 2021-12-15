require 'rails_helper'

describe 'api/v1/registrations_controller', type: :request do

  context 'When creating a new user' do
    before :each do
      @user = create(:user)
      post '/api/signup', params: {
        user: {
          name: @user.name,
          email: "test#{@user.email}",
          password: @user.password,
          password_confirmation: @user.password
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end
    
    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns the user email' do
      expect(JSON.parse(response.body)['data']['email']).to eq("test#{@user.email}")
    end
  end

  context 'When creating an invalid user' do
    before do
      post '/api/signup', params: {
        user: {
          name: 'test',
          email: "test@gmail.com",
          password: "123456",
          password_confirmation: "123456"
        }
      }
    end

    it 'should return 422 if name is too short' do
      expect(response.status).to eq(422)
    end

    before do
      post '/api/signup', params: {
        user: {
          name: 'testtest',
          email: "test@gmail.com",
          password: "123457",
          password_confirmation: "123456"
        }
      }
    end

    it 'should return 422 if passwords dont match' do
      expect(response.status).to eq(422)
    end
  end
end