require 'test_helper'

class ContentsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get contents_top_url
    assert_response :success
  end

end
