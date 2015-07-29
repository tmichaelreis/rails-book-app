require 'test_helper'

class BookTest < ActiveSupport::TestCase
  
  def setup
    @book = Book.new(title: "test title", author: "author", isbn: "test isbn")
    @gatsby = books(:gatsby)
  end
  
  test "should be valid" do
    assert @book.valid?
  end
  
  test "isbn should be present" do
    @book.isbn = ""
    assert_not @book.valid?
  end
  
  # Ordering test - need to order on relations, not on books
  test "order should show most recent first" do
    assert_equal books(:most_recent), Book.first
  end
  
  test "should select book from database" do
    assert_equal Book.search_db("Gatsby")[0], @gatsby
  end
end
