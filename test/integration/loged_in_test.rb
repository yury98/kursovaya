require 'test_helper'
require_relative '../controllers/login_part'

class LogedInTest < ActionDispatch::IntegrationTest
  test "login_test" do
    get "/users/sign_up"
    assert_response :success

    post "/users",
         params: { user: { email: "yshashkin@yandex.ru", password: "123456", password_confirmation: "123456"  } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    get contragents_main_url
    assert_response :success
    assert_equal request.original_url, contragents_main_url
  end

  test "orgs_loged_in" do
    login_help
    @url = 'http://www.example.com'

    get orgs_main_path
    assert_response :success
    assert_equal request.original_url, @url + orgs_main_path

    get orgs_view_path
    assert_response :success
    assert_equal request.original_url, @url + orgs_view_path

    get orgs_dump_path
    assert_response :success
    assert_equal request.original_url, @url + orgs_dump_path
  end

  test "contracts_loged_in" do
    login_help
    @url = 'http://www.example.com'

    get contracts_main_path
    assert_response :success
    assert_equal request.original_url, @url + contracts_main_path

    get contracts_all_path
    assert_response :success
    assert_equal request.original_url, @url + contracts_all_path

    get contracts_view_path
    assert_response :success
    assert_equal request.original_url, @url + contracts_view_path
  end

  test "contagents_loged_in" do
    login_help
    @url = 'http://www.example.com'

    get contragents_main_path
    assert_response :success
    assert_equal request.original_url, @url + contragents_main_path

    get contragents_dump_path
    assert_response :success
    assert_equal request.original_url, @url + contragents_dump_path

    get contragents_view_path
    assert_response :success
    assert_equal request.original_url, @url + contragents_view_path
  end

  test "payments_loged_in" do
    login_help
    @url = 'http://www.example.com'

    get payments_new_path
    assert_response :success
    assert_equal request.original_url, @url + payments_new_path

    get payments_plan_each_path
    assert_response :success
    assert_equal request.original_url, @url + payments_plan_each_path

    get payments_services_each_path
    assert_response :success
    assert_equal request.original_url, @url + payments_services_each_path
  end
end
