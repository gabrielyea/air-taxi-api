require 'swagger_helper'

RSpec.describe 'api/v1/planes', type: :request do

  path '/api/v1/planes' do

    get('list planes') do
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
          tour_price: { type: :integer }
        },
        required: [ 'model', 'description', 'tour_price' ]
      }
      
      response('201', 'blog created') do
        let(:plane) { { model: 'foo', description: 'bar', tour_price: '100' } }
        run_test!
      end

      # response(200, 'successful') do

      #   # after do |example|
      #   #   example.metadata[:response][:content] = {
      #   #     'application/json' => {
      #   #       example: JSON.parse(response.body, symbolize_names: true)
      #   #     }
      #   #   }
      #   # end
      #   # run_test!
      # end
    end
  end

  path '/api/v1/planes/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show plane') do
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
