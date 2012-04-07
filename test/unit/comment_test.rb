# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  message    :text
#  post_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should be valid if message, post and user are there" do
    post = posts(:one)
    comment = comments(:one)

    assert_equal false, comment.valid?

    comment.post = post
    assert_equal false, comment.valid?

    comment.user = users(:one)
    assert_equal true, comment.valid?
  end

  test "should not be empty and not to large" do

    comment = Comment.new
    comment.post = posts(:one)
    comment.user = users(:one)

    comment.message = ""
    assert_equal false, comment.valid?

    comment.message = 'a' * 601
    assert_equal false, comment.valid?

    comment.message = "Okay"
    assert_equal true, comment.valid?
  end


end
