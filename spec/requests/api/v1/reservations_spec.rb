require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do
  path '/api/v1/planes/{plane_id}/reservations' do
    # You'll want to customize the parameter types...
    parameter name: 'plane_id', in: :path, type: :string, description: 'plane_id'

    get('list reservations') do
      tags 'Reservations'
      response(200, 'successful') do
        let(:plane_id) { '123' }

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

    post('create reservations') do
      tags 'Reservations'
      consumes 'application/json'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          reserve_date: { type: :string }
        },
        required: [ 'reserve_date' ]
      }
      
      response('201', 'Reservation created!') do
        let(:reservation) { { reserve_date: '5/5/5' } }
        run_test!
      end
    end
  end

  path '/api/v1/planes/{plane_id}/reservations/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'plane_id', in: :path, type: :string, description: 'plane_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show reservation') do
      tags 'Reservations'
      response(200, 'successful') do
        let(:plane_id) { '123' }
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
