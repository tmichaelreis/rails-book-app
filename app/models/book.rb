class Book < ActiveRecord::Base
  has_many :relationships, class_name: 'Relationship',
                           foreign_key: 'book_id',
                           dependent: :destroy
  has_many :readers, through: :relationships
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :isbn, presence: true
  
  def self.search_db(query)
      where('title LIKE ? OR author LIKE ?', "%#{query}%", "%#{query}%")
  end
end
