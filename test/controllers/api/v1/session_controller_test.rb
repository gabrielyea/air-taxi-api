require 'test_helper'

class Api::V1::SessionControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get api_v1_session_create_url
    assert_response :success
  end
end
