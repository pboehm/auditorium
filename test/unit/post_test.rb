# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  message    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should restrict the lenght of the message" do

    post = Post.new(:user => users(:one))
    post.message = ""
    assert_equal false, post.valid?

    post.message = 'a' * 14
    assert_equal false, post.valid?

    post.message = 'a' * 23
    assert_equal true, post.valid?

    post.message = 'a' * 600
    assert_equal true, post.valid?

    post.message = 'a' * 601
    assert_equal false, post.valid?
  end

end
