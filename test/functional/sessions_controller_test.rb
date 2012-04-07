require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
    @dbuser = users(:one)
    @args = { :email => 'test.testnutzer@uni-rostock.de',
              :password => 'testtest',
            }
  end

  test "should reject the login if credentials are wrong" do

    get :new
    assert_response :success
    assert_select 'div.page-header', :text => 'Login'

    post :create, @args.merge({:email => 'testtest.test@uni-rostock.de'})
    assert_select 'div.alert', :text => /Passwort.sind.nicht.korrekt/

    post :create, @args.merge({:password => 'testtesttest'})
    assert_select 'div.alert', :text => /Passwort.sind.nicht.korrekt/
  end

  test "should login successful if the supplied ceredentials are right" do

    post :create, @args
    assert_redirected_to root_path
  end

  test "should logout if the user wants to logout" do
    post :create, @args
    assert_redirected_to root_path

    get :destroy
    assert_match /ausgeloggt/, flash[:notice]
  end

  test "should redirect to root url if a logged in users visit new action" do
    post :create, @args
    assert_redirected_to root_path

    get :new
    assert_redirected_to root_path
  end

end
