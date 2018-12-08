require 'test_helper'

class InfoAdminTest < ActiveSupport::TestCase
  setup do
    @res = info_admins(:one)
  end

  test "should save" do
    res = InfoAdmin.create :post => (@res.post + 'xsd')
    res.save
    assert InfoAdmin.find_by_post(@res.post + 'xsd')
  end
end
