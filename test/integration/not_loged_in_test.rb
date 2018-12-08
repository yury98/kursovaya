require 'test_helper'

class NotLogedInTest < ActionDispatch::IntegrationTest
  test "login_test" do
    get "/users/sign_up"
    assert_response :success
    get "/users/sign_in"
    assert_response :success
  end

  test "admin_not_loged_in" do
    @url = 'http://www.example.com'

    get admin_info_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get admin_stats_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'
  end

  test "orgs_not_loged_in" do
    @url = 'http://www.example.com'

    get orgs_main_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get orgs_view_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get orgs_contracts_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get orgs_dump_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'
  end

  test "contracts_not_loged_in" do
    @url = 'http://www.example.com'

    get contracts_main_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get contracts_all_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get contracts_show_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get contracts_view_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'
  end

  test "contagents_not_loged_in" do
    @url = 'http://www.example.com'

    get contragents_main_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get contragents_dump_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get contragents_view_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'
  end

  test "payments_not_loged_in" do
    @url = 'http://www.example.com'

    get payments_new_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get payments_download_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get payments_paid_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get payments_plan_all_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get payments_plan_each_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get payments_services_all_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'

    get payments_view_path
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + '/users/sign_in'
  end
end
