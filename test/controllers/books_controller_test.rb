require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  require 'test_helper'

  def setup
    @book = books(:gatsby)
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
end