require 'swagger_helper'

RSpec.describe 'api/v1/sessions', type: :request do

  path '/api/login' do

    get('new session') do
      tags 'Session'
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create session') do
      tags 'Session'
      consumes 'application/json'
      parameter name: :login, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
        },
        required: [ 'email', 'password' ]
      }
      
      response('201', 'You are login!') do
        let(:login) { { email: '123456@gmail.com', password: '123456' } }
        run_test!
      end
    end
  end

  path '/api/logout' do

    delete('delete session') do
      tags 'Session'
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
