# == Schema Information
#
# Table name: events
#
#  id          :integer         not null, primary key
#  time        :datetime
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  user_id     :integer
#  place       :string(255)
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase

  test "should reject events with inappropriate params" do
    event = Event.new

    assert_equal false, event.valid?

    event.at = Time.now
    event.description = "Testtermin"
    event.user = users(:one)

    assert_equal true, event.valid?
  end

  test "should enforce the length of the description" do
    event = Event.new(user: users(:one), at:Time.now)

    event.description = ""
    assert_equal false, event.valid?

    event.description = "a" * 1000
    assert_equal false, event.valid?

    event.description = "testtest"
    assert_equal true, event.valid?
  end

end
