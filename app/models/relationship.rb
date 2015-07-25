class Relationship < ActiveRecord::Base
  belongs_to :reader, class_name: "User"
  belongs_to :book, class_name: "Book"
  validates :reader_id, presence: true
  validates :book_id, presence: true
end
