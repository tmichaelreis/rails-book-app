require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  require 'test_helper'

  def setup
    @book = books(:gatsby)
    @user = users(:testuser)
  end
  
  test "should find a book in db" do
    log_in_as(@user)
    get :search, search: "Gatsby"
    assert_response :success
    assert_includes @response.body, 'The Great Gatsby'
  end
end