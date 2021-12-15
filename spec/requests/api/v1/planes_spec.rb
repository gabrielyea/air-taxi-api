require 'swagger_helper'

RSpec.describe 'api/v1/planes', type: :request do

  before :all do
    @user = create(:user)
    login_with_api(@user)
  end
  let(:Authorization) { "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjp7ImlkIjoxLCJlbWFpbCI6ImdyZXRhQHF1aWdsZXktaGVybWFuLmJpeiIsIm5hbWUiOiJDYXJzb24gQmFydG9sZXR0aSIsImNyZWF0ZWRfYXQiOiIyMDIxLTEyLTE0VDIzOjU0OjI0LjY3MVoiLCJ1cGRhdGVkX2F0IjoiMjAyMS0xMi0xNFQyMzo1NDoyNC42NzFaIn0sInN1YiI6IjEiLCJzY3AiOiJ1c2VyIiwiYXVkIjpudWxsLCJpYXQiOjE2Mzk1MjYwNjQsImV4cCI6MTYzOTYxMjQ2NCwianRpIjoiNTFmZWM2OGItMjUzOS00NThjLTkxODAtODk5YzgwMDU3MjkzIn0.7_TefMbJhcxxzjKOIkX7y4C1ILN4mLzopjd6eeiA784" }

  path '/api/v1/planes' do
      get('list planes') do
        tags 'Planes'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
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
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string
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
      
      response '201', 'Plane created!'  do
        let(:plane) { { model: 'foo', description: 'bar', tour_price: '100', registration: 'XA123', cruise_speed: '100', picture: 'mypicture.com' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:plane) { {model: ''} }
        run_test!
      end
    end
  end
end
  # path '/api/v1/planes/{id}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'

  #   get('show plane') do
  #     tags 'Planes'
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end

  #   delete('delete plane') do
  #     tags 'Planes'
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
#   end
# end
