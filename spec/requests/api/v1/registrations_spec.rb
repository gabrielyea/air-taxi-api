require 'swagger_helper'

RSpec.describe 'api/v1/registrations', type: :request do

  path '/api/signup' do
    before do
      @user = create(:user)
    end

    parameter name: :user, in: :body, schema: {
      type: :object,
      properties: {
        name: { type: :string },
        email: { type: :string },
        password: { type: :string },
        password_confrimation: { type: :string }
      },
      required: [ 'name', 'email', 'password', 'password_confirmation' ]
    }

    post('new registration') do
      tags 'Registration'
      consumes 'application/json'
      
      let(:user) { { user: {
        name: "dan1234",
        email: "dan2@gmail.com",
        password: "123456",
        password_confirmation: "123456"
        }
      }}

      response(200, 'User created with valid token') do
        run_test! do |response|
          expect(response.header['Authorization']).to be_present
        end
      end
    end

    post('new registration') do
      tags 'Registration'
      consumes 'application/json'
      
      let(:user) { { user: {
        name: "dan21223",
        email: @user.email,
        password: "123456",
        password_confirmation: "123456"
        }
      }}

      response(422, 'Email already exists') do
        run_test! do |response|
          expect(body_json['message']).to eq('Something went wrong.')
        end
      end
    end
  end

  path '/api/signup' do
    before do
      @user = create(:user)
      @user
      login_with_api(@user)
      @authorization = response.header['Authorization']
    end
    let(:Authorization) { @authorization }

    delete('delete registration') do
      tags 'Registration'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string

      response(200, 'successful') do
        run_test! do |response|
          expect(body_json['message']).to eq('User deleted')
        end
      end
    end
  end
end
