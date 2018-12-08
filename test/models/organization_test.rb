require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  setup do
    @res = orgs(:one)
  end

  test "should save" do
    res = Org.create :name => (@res.name + 'xsd')
    res.save
    assert Org.find_by_name(@res.name + 'xsd')
  end
end
