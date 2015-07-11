require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
    test "full_title_helper" do
        assert_equal full_title, "Book Club"
        assert_equal full_title("Help"), "Help | Book Club"
    end
end