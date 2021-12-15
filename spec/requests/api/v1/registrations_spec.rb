require 'swagger_helper'

RSpec.describe 'api/v1/registrations', type: :request do

  before (:each) do
    @user = create(:user)
    # p @user
    login_with_api(@user)
    # @authorization = response.header['Authorization']
  end

  # let(:Authorization) { @authorization }

  path '/api/signup' do

    post('new registration') do
      tags 'Registration'
      consumes 'application/json'
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
      let(:user) { { user: {
        name: "dan21223",
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
  end

  # path '/api/signup/edit' do

  #   get('edit registration') do
  #     tags 'Registration'
  #     response(200, 'successful') do

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
  # end

  # path '/api/signup' do

  #   patch('update registration') do
  #     tags 'Registration'
  #     response(200, 'successful') do

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

  #   put('update registration') do
  #     tags 'Registration'
  #     response(200, 'successful') do

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

  #   delete('delete registration') do
  #     tags 'Registration'
  #     response(200, 'successful') do

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
end
