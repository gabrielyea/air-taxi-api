# spec/controllers/api/registrations_controller_spec.rb
require 'rails_helper'

describe 'api/v1/sessions_controller', type: :request do

  context 'When creating a new user' do
    # before(:each) do
    #   @user = create(:user)
    # end
    
    before do
      @user = create(:user)
      p @user
      post '/api/login', params: {
        user: {
          email: @user.email,
          password: @user.password
        }
      }
    end

    it 'returns 200' do
      p @user
      # expect(response.status).to eq(200)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns the user email' do
      expect(json['data']).to have_attribute(:email).with_value(@user.email)
    end
  end

  context 'When an email already exists' do
    before do
      post signup_url, params: {
        user: {
          email: existing_user.email,
          password: existing_user.password
        }
      }
    end

    it 'returns 400' do
      expect(response.status).to eq(400)
    end
  end

end
