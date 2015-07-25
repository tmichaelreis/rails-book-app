require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(reader_id: 1, book_id: 2)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "should require a reader_id" do
    @relationship.reader_id = nil
    assert_not @relationship.valid?
  end

  test "should require a followed_id" do
    @relationship.book_id = nil
    assert_not @relationship.valid?
  end
end
