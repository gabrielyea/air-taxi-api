require 'swagger_helper'

RSpec.describe 'api/v1/sessions', type: :request do

  before :each do
    @user = create(:user)
    login_with_api(@user)
    @authorization = response.header['Authorization']
  end

  let(:Authorization) { @authorization }

  path '/api/login' do
    post('create session') do
      tags 'Session'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
        },
        required: [ 'email', 'password' ]
      }

      let(:user) {{user: {email: @user.email, password: @user.password }}}
      response(200, 'Log in success') do
      run_test! do |response|
        expect(body_json['data']['name']).to eq(@user['name'])
      end
    end
    end
  end

  path '/api/logout' do

    delete('delete session') do
      tags 'Session'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string
      parameter name: 'id', in: :path, type: :string, description: 'id'

        response(200, 'successful') do
          let(:id) { @user.id }
          run_test! do |response|
            expect(body_json['message']).to eq('You are logged out.')
          end
        end
      end
    end
end
