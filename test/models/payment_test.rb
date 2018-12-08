require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  setup do
    @res = payments(:one)
  end

  test "should save" do
    res = Payment.create :number => (@res.number + 10)
    res.save
    assert Payment.find_by_number(@res.number + 10)
  end
end
