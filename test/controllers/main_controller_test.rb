require 'test_helper'
require_relative 'login_part'

class MainControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_help
  end

  test "should get index" do
    get main_index_url
    assert_response :success
  end
end
