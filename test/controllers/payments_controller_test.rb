require 'test_helper'
require_relative 'login_part'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_help
    @url = 'http://www.example.com'
    @pay = payments(:one)
    @con = contracts(:one)
    @org = orgs(:one)
    @co = contragents(:one)
  end

  test "should create payment" do
    assert_difference('Payment.count') do
      post "/payments", params: { payment: { number: @pay.number + 10, contract_id: Contract.find_by_name(@con.name).id, date: 1, month: 1, summ: 120.0 } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + "/payments/#{Payment.find_by_number(@pay.number + 10).id}"
  end

  test "should update payment" do
    assert_no_difference('Payment.count') do
      patch "/payments/#{Payment.find_by_number(@pay.number).id}", params: { payment: { number: @pay.number + 10, contract_id: Contract.find_by_name(@con.name).id, date: 1, month: 1, summ: 120.0 } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal request.original_url, @url + "/payments/#{Payment.find_by_number(@pay.number + 10).id}"
    assert Payment.find_by_number(@pay.number + 10)
    assert_not Payment.find_by_number(@pay.number)
  end

  test "should show plan_all" do
    post "/payments/plan_all", params: { month: {'month(1i)': 2018, 'month(2i)': 12, 'month(3i)': 1 } }
    assert_response :success
    assert_equal request.original_url, @url + "/payments/plan_all"
  end

  test "should show services_all" do
    post "/payments/services_all", params: { month: {'month(1i)': 2018, 'month(2i)': 12, 'month(3i)': 1 } }
    assert_response :success
    assert_equal request.original_url, @url + "/payments/services_all"
  end
end
