class Book < ActiveRecord::Base
  has_many :relationships, class_name: 'Relationship',
                           foreign_key: 'book_id',
                           dependent: :destroy
  has_many :readers, through: :relationships
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :openlibrary_key, presence: true, 
            uniqueness: { case_sensitive: false }
  
  def self.search_db(query)
      where('LOWER(title) LIKE LOWER(?) OR LOWER(author) LIKE LOWER(?)', 
            "%#{query}%", "%#{query}%")
  end
end
