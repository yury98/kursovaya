require 'test_helper'
require_relative '../controllers/login_part'

class AdminTest < ActionDispatch::IntegrationTest
  setup do
    login_help
    @url = 'http://www.example.com'
  end

  test "not admin" do
    get admin_info_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + main_index_path

    get admin_stats_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + main_index_path
  end

  test "admin" do
    admin_help

    get admin_info_path
    assert_response :success
    assert_equal request.original_url, @url + admin_info_path

    get admin_stats_path
    assert_response :success
    assert_equal request.original_url, @url + admin_stats_path
  end
end
