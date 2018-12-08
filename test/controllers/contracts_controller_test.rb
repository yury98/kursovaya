require 'test_helper'
require_relative 'login_part'

class ContractsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_help
    @url = 'http://www.example.com'
    @con = contracts(:one)
    @org = orgs(:one)
    @co = contragents(:one)
  end

  test "should get main" do
    get contracts_main_url
    assert_response :success
  end

  test "should get view" do
    get contracts_view_url
    assert_response :success
  end

  test "should get all" do
    get contracts_all_url
    assert_response :success
  end

  test "should create contract" do
    assert_difference('Contract.count') do
      post "/contracts", params: { contract: { name: @con.name + 'viedhlsk', nds: 32, gvs: true, v_gvs: 23, t_gvs: 23, o_gvs: 529, price: 78562,\
      org_id: Org.find_by_name(@org.name).id, contragent_id: Contragent.find_by_name(@co.name).id } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + "/contracts/#{Contract.find_by_name(@con.name + 'viedhlsk').id}"
  end

  test "should update contract" do
    assert_no_difference('Contract.count') do
      patch "/contracts/#{Contract.find_by_name(@con.name).id}", params: { contract: { name: @con.name + 'viedhlsk', nds: 32,\
      gvs: true, v_gvs: 23, t_gvs: 23, o_gvs: 529, price: 78562, org_id: Org.find_by_name(@org.name).id,\
      contragent_id: Contragent.find_by_name(@co.name).id } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + "/contracts/#{Contract.find_by_name(@con.name + 'viedhlsk').id}"
    assert Contract.find_by_name(@con.name + 'viedhlsk')
    assert_not Contract.find_by_name(@con.name)
  end

end
