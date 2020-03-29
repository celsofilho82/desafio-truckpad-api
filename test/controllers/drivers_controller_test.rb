require 'test_helper'

class DriversControllerTest < ActionDispatch::IntegrationTest
  setup do
    @driver = drivers(:one)
  end

  test "should get index" do
    get drivers_url, as: :json
    assert_response :success
  end

  test "should create driver" do
    assert_difference('Driver.count') do
      post drivers_url, params: { driver: { cnh_type: @driver.cnh_type, gender: @driver.gender, has_truck: @driver.has_truck, name: @driver.name, truck_id: @driver.truck_id } }, as: :json
    end

    assert_response 201
  end

  test "should show driver" do
    get driver_url(@driver), as: :json
    assert_response :success
  end

  test "should update driver" do
    patch driver_url(@driver), params: { driver: { cnh_type: @driver.cnh_type, gender: @driver.gender, has_truck: @driver.has_truck, name: @driver.name, truck_id: @driver.truck_id } }, as: :json
    assert_response 200
  end

  test "should destroy driver" do
    assert_difference('Driver.count', -1) do
      delete driver_url(@driver), as: :json
    end

    assert_response 204
  end
end
