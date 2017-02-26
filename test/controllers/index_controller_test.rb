require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get index_main_url
    assert_response :success
  end

end
