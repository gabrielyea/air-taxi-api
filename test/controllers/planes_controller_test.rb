require 'test_helper'

class PlanesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @plane = planes(:one)
  end

  test 'should get index' do
    get planes_url, as: :json
    assert_response :success
  end

  test 'should create plane' do
    assert_difference('Plane.count') do
      post planes_url,
           params: { plane: { cruise_speed: @plane.cruise_speed, description: @plane.description, model: @plane.model, registration: @plane.registration, reservation_id: @plane.reservation_id, tour_price: @plane.tour_price } }, as: :json
    end

    assert_response 201
  end

  test 'should show plane' do
    get plane_url(@plane), as: :json
    assert_response :success
  end

  test 'should update plane' do
    patch plane_url(@plane),
          params: { plane: { cruise_speed: @plane.cruise_speed, description: @plane.description, model: @plane.model, registration: @plane.registration, reservation_id: @plane.reservation_id, tour_price: @plane.tour_price } }, as: :json
    assert_response 200
  end

  test 'should destroy plane' do
    assert_difference('Plane.count', -1) do
      delete plane_url(@plane), as: :json
    end

    assert_response 204
  end
end
