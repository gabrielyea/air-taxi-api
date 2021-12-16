require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do
  before :each do
    @user = create(:user)
    @plane = create(:plane)
    @reservation = create(:reservation, user_id: @user.id, plane_id: @plane.id)
    login_with_api(@user)
    @authorization = response.header['Authorization']
  end

  let(:Authorization) { @authorization }

  path '/api/v1/planes/{plane_id}/reservations' do
    parameter name: :Authorization, in: :header, type: :string
    parameter name: 'plane_id', in: :path, type: :string, description: 'plane_id'

    get('list reservations') do
      tags 'Reservations'
      consumes 'application/json'
      security [Bearer: {}]
      response(200, 'successful') do
        let(:plane_id) { @plane.id }
        run_test! do |response|
          expect(body_json.count).to be(1)
        end
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
        let(:plane_id) { @plane.id }
        let(:reservation) { { reserve_date: '5/5/5' } }
        run_test! do |response|
          expect(body_json['reserve_date']).to eq('0005-05-05')
        end
      end
    end

    path '/api/v1/planes/{plane_id}/reservations/{id}' do
      parameter name: :Authorization, in: :header, type: :string
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: 'plane_id', in: :path, type: :string, description: 'plane_id'

      get('show reservation') do
        tags 'Reservations'
        response(200, 'successful') do
          let(:plane_id) { @plane.id }
          let(:id) { @reservation.id }
          run_test! do |response|
            expect(body_json['user_id']).to eq(@user.id)
          end
        end
      end
    end
  end
end