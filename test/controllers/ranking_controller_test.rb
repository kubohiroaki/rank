require 'test_helper'

class RankingControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get ranking_top_url
    assert_response :success
  end

end
