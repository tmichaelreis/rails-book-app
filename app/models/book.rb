class Book < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :isbn, presence: true
  validates :rating, :inclusion => 1..5, presence: true
  validates :review, :allow_blank => true, :allow_nil => true,
                     length: { maximum: 140 }
end
