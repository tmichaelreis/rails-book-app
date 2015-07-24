require 'test_helper'

class BookTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:testuser)
    @book = @user.books.build(title: "test title", isbn: "test isbn", 
                              review: "review", rating: 2)
  end
  
  test "should be valid" do
    assert @book.valid?
  end
  
  test "user id should be present" do
    @book.user_id = nil
    assert_not @book.valid?
  end
  
  test "isbn should be present" do
    @book.isbn = ""
    assert_not @book.valid?
  end
  
  test "rating should be present" do
    @book.rating = nil
    assert_not @book.valid?
  end
  
  test "rating should be 1 or greater" do
    @book.rating = 0
    assert_not @book.valid?
  end
  
  test "rating should be 5 or less" do
    @book.rating = 6
    assert_not @book.valid?
  end
  
  test "review, if present, should be less than 140 characters" do
    @book.review = "a" * 141
    assert_not @book.valid?
  end
  
  # Ordering test - will need to remove or use an || in the future
  test "order should show most recent first" do
    assert_equal books(:most_recent), Book.first
  end
end
