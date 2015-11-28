require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get timeline" do
    get :timeline
    assert_response :success
  end

end
