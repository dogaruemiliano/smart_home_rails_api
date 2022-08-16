require "test_helper"

class Api::V1::AirConditionersControllerTest < ActionDispatch::IntegrationTest
  test "should get get_state" do
    get api_v1_air_conditioners_get_state_url
    assert_response :success
  end
end
