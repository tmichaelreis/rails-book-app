require 'test_helper'

class BookSearchTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:testuser)
  end
  
  test "show api search results" do
    log_in_as(@user)
    post search_path, search: "Lord of the Rings"
    assert_template 'books/search'
    assert_template partial: 'books/_api_list_form'
    assert_select 'span.list_link'
  end
end
