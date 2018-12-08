require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @res = users(:one)
  end

  test "should save" do
    res = User.create :email => (@res.email)
    res.save
    assert User.find_by_email(@res.email)
  end
end
