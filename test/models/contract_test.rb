require 'test_helper'

class ContractTest < ActiveSupport::TestCase
  setup do
    @res = contracts(:one)
  end

  test "should save" do
    res = Contract.create :name => (@res.name + 'xsd')
    res.save
    assert Contract.find_by_name(@res.name + 'xsd')
  end
end
