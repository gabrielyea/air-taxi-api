require 'swagger_helper'

RSpec.describe 'api/v1/planes', type: :request do

  before :all do
    @user = create(:user)
    login_with_api(@user)
    @plane = create(:plane)
    @authorization = response.header['Authorization']
  end

  let(:Authorization) { @authorization }

  path '/api/v1/planes' do
      get('list planes') do
        tags 'Planes'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string

        response(200, 'successful') do
          run_test! do |response|
            expect(body_json.count).to be(1)
          end
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
      
      response('201', 'Plane created!') do
        let(:plane) { { model: 'foo', description: 'bar', tour_price: '100', registration: 'XA123', cruise_speed: '100', picture: 'mypicture.com' } }
        run_test!
      end

      response('422', 'invalid request') do
        let(:plane) { {model: ''} }
        run_test!
      end
    end
  end

  path '/api/v1/planes/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show plane') do
      tags 'Planes'
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string

      response(200, 'successful') do
        let(:id) { '1' }    
        run_test! do |response|
          expect(body_json['model']).to eq(@plane['model'])
        end
      end
    end

    delete('delete plane') do
      tags 'Planes'
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string

      response(200, 'successful') do
        let(:id) { @plane.id }
        run_test! do |response|
          expect(body_json['message']).to eq('Plane record deleted')
        end
      end
    end
  end
end
