# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  message    :text
#  post_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should be valid if message and post are there" do
    post = posts(:one)
    comment = comments(:one)

    assert_equal false, comment.valid?

    comment.post = post
    assert_equal true, comment.valid?
  end

  test "should not be empty and not to large" do
    post = posts(:one)

    comment = Comment.new
    comment.post = post

    comment.message = ""
    assert_equal false, comment.valid?

    comment.message = 'a' * 601
    assert_equal false, comment.valid?

    comment.message = "Okay"
    assert_equal true, comment.valid?
  end


end
