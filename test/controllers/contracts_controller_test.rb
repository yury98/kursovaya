require 'test_helper'

class ContractsControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get contracts_main_url
    assert_response :success
  end

  test "should get new" do
    get contracts_new_url
    assert_response :success
  end

  test "should get view" do
    get contracts_view_url
    assert_response :success
  end

  test "should get view_each" do
    get contracts_view_each_url
    assert_response :success
  end

  test "should get edit" do
    get contracts_edit_url
    assert_response :success
  end

  test "should get all" do
    get contracts_all_url
    assert_response :success
  end

end
