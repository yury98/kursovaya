require 'test_helper'

class OrgControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get org_main_url
    assert_response :success
  end

  test "should get new" do
    get org_new_url
    assert_response :success
  end

  test "should get view" do
    get org_view_url
    assert_response :success
  end

end
