ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def login(email="test.testnutzer@uni-rostock.de", password="testtest")
    old_controller = @controller
    @controller = SessionsController.new

    post :create, { :email => email, :password => password }
    assert_match /eingeloggt/, flash[:notice]
    assert_redirected_to root_path

    @controller = old_controller
  end
end
