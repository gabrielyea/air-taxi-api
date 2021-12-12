require 'swagger_helper'

RSpec.describe 'api/v1/planes', type: :request do
  path '/api/v1/planes' do
    get('list planes') do
      tags 'Planes'
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

    post('create plane') do
      tags 'Planes'
      consumes 'application/json'
      parameter name: :plane, in: :body, schema: {
        type: :object,
        properties: {
          model: { type: :string },
          description: { type: :string },
          registration: { type: :string },
          cruise_speed: { type: :integer },
          tour_price: { type: :integer },
          picture: { type: :string}
        },
        required: [ 'model', 'description', 'tour_price', 'picture', 'registration', 'cruise_speed' ]
      }
      
      response('201', 'Plane created!') do
        let(:plane) { { model: 'foo', description: 'bar', tour_price: '100', registration: 'XA123', cruise_speed: '100', picture: 'mypicture.com' } }
        run_test!
      end
    end
  end

  path '/api/v1/planes/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show plane') do
      tags 'Planes'
      response(200, 'successful') do
        let(:id) { '123' }

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

    delete('delete plane') do
      tags 'Planes'
      response(200, 'successful') do
        let(:id) { '123' }

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
