require 'test_helper'

class ContragentTest < ActiveSupport::TestCase
  setup do
    @res = contragents(:one)
  end

  test "should save" do
    res = Contragent.create :name => (@res.name + 'xsd')
    res.save
    assert Contragent.find_by_name(@res.name + 'xsd')
  end
end
