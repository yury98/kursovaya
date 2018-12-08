require 'test_helper'
require_relative 'login_part'

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_help
    admin_help
    @url = 'http://www.example.com'
    @info = info_admins(:one)
  end

  test "admin info" do
    get admin_info_path
    assert_response :success
    assert_equal request.original_url, @url + admin_info_path
  end

  test "admin stats" do
    get admin_stats_path
    assert_response :success
    assert_equal request.original_url, @url + admin_stats_path
  end

  test "should create info" do
    assert_difference('InfoAdmin.count') do
      post "/admin/new", params: { info_admin: { post: @info.post + 'cd' } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + main_index_path
  end
end
