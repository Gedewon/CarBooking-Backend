require 'test_helper'

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get api_v1_sessions_index_url
    assert_response :success
  end
end
