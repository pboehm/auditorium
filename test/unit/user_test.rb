# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  email            :string(255)
#  password_digest  :string(255)
#  name             :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  last_login       :datetime
#  notify_new_posts :boolean         default(TRUE)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @arg = {  :email => "secondtest.testnutzer@uni-rostock.de",
              :password => "secret",
              :password_confirmation => "secret",
    }
  end

  test "users with different passwords should not be valid" do
    user = User.new(@arg.merge({ :password_confirmation => "notsecret" }))
    assert_equal false, user.valid?
  end

  test "should have the right email address" do

    user = User.new(@arg.merge({ :email => "not.an.email.address" }))
    assert_equal false, user.valid?

    user = User.new(@arg.merge({ :email => "hans.wurst@web.de" }))
    assert_equal false, user.valid?

    validuser = User.new(@arg)
    assert_equal true, validuser.valid?
  end

  test "emails should be unique" do
    user = User.new(@arg)
    user.save

    anotheruser = User.new(@arg)
    assert_equal false, anotheruser.valid?
  end

  test "should axtract the right name from the email field" do
    user = User.new(@arg)
    user.save
    assert_equal "Secondtest Testnutzer", user.name
  end

  test "should authenticate the user" do
    user = User.new(@arg)
    user.save

    userfromdb = User.find_by_email(@arg[:email])
    assert_equal false, userfromdb.authenticate('nottherightpassword')

    assert_equal userfromdb, userfromdb.authenticate(@arg[:password])
  end

  test "should have a method that nromalized the supplied email" do
    email = User.normalize_email(@arg[:email])
    assert_equal @arg[:email], email

    normalized = User.normalize_email('test.testnutzer')
    assert_equal "test.testnutzer@uni-rostock.de", normalized
  end



end
