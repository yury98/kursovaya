require 'test_helper'
require_relative 'login_part'

class OrgControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_help
    @url = 'http://www.example.com'
    @org = orgs(:one)
  end

  test "should get main" do
    get orgs_main_path
    assert_response :success
  end

  test "should get view" do
    get orgs_view_path
    assert_response :success
  end

  test "should create org" do
    assert_difference('Org.count') do
      post "/orgs", params: { org: { name: @org.name + 'cd' } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + "/orgs/#{Org.find_by_name(@org.name + 'cd').id}"
  end

  test "should delete org" do
    assert_no_difference('Org.count') do
      delete "/orgs/#{Org.find_by_name(@org.name).id}"
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + orgs_view_path
    assert Org.find_by_name(@org.name).status
  end

  test "should update org" do
    assert_no_difference('Org.count') do
      patch "/orgs/#{Org.find_by_name(@org.name).id}", params: { org: { name: @org.name + 'viedhlsk' } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + "/orgs/#{Org.find_by_name(@org.name + 'viedhlsk').id}"
    assert Org.find_by_name(@org.name + 'viedhlsk')
    assert_not Org.find_by_name(@org.name)
  end

end
