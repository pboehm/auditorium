# == Schema Information
#
# Table name: visits
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  post_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

class VisitTest < ActiveSupport::TestCase

  test "should reject invalid visits" do
    visit = Visit.new(post: posts(:one))
    assert_equal false, visit.valid?

    visit.user = users(:one)
    assert_equal true, visit.valid?
  end

  test "should reject two equal entries" do
    visit = Visit.new(post: posts(:one), user: users(:one))
    visit.save

    eqvisit = Visit.new(post: posts(:one), user: users(:one))
    assert_equal false, eqvisit.valid?

  end
end
