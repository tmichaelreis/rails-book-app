require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  require 'test_helper'

  def setup
    @book = books(:gatsby)
    @user = users(:testuser)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Book.count' do
      post :create, book: { title: "Lorem ipsum", isbn: "45434543", 
                            rating: 3, review: "foobar", thumbnail_url: "baz" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Book.count' do
      delete :destroy, id: @book
    end
    assert_redirected_to login_url
  end
  
  test "should find a book in db" do
    log_in_as(@user)
    get :search, search: "Gatsby"
    assert_response :success
    assert_includes @response.body, 'The Great Gatsby'
  end
end