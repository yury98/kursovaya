require 'test_helper'
require_relative 'login_part'

class ContragentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_help
    @url = 'http://www.example.com'
    @con = contragents(:one)
  end

  test "should get main" do
    get contragents_main_url
    assert_response :success
  end

  test "should get view" do
    get contragents_view_url
    assert_response :success
  end

  test "should get dump" do
    get contragents_dump_url
    assert_response :success
  end

  test "should create contagent" do
    assert_difference('Contragent.count') do
      post "/contragents", params: { contragent: { name: @con.name + 'cd' } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + "/contragents/#{Contragent.find_by_name(@con.name + 'cd').id}"
  end

  test "should delete contagent" do
    assert_no_difference('Contragent.count') do
      delete "/contragents/#{Contragent.find_by_name(@con.name).id}"
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + contragents_view_path
    assert Contragent.find_by_name(@con.name).status
  end

  test "should update contagent" do
    assert_no_difference('Contragent.count') do
      patch "/contragents/#{Contragent.find_by_name(@con.name).id}", params: { contragent: { name: @con.name + 'viedhlsk' } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + "/contragents/#{Contragent.find_by_name(@con.name + 'viedhlsk').id}"
    assert Contragent.find_by_name(@con.name + 'viedhlsk')
    assert_not Contragent.find_by_name(@con.name)
  end

end
