require 'test_helper'

class ContragentsControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get contragents_main_url
    assert_response :success
  end

  test "should get new" do
    get contragents_new_url
    assert_response :success
  end

  test "should get view" do
    get contragents_view_url
    assert_response :success
  end

  test "should get edit" do
    get contragents_edit_url
    assert_response :success
  end

  test "should get dump" do
    get contragents_dump_url
    assert_response :success
  end

end
