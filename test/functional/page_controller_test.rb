require 'test_helper'

class PageControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success

  end

  test "should contains the hero unit" do
    get :index

    assert_select "div.hero-unit" do
      assert_select "h1", "Willkommen"
    end
  end
end
