class User < ActiveRecord::Base
  has_many :relationships, class_name: 'Relationship',
                           foreign_key: 'reader_id',
                           dependent: :destroy
  has_many :books, through: :relationships
  attr_accessor :remember_token, :reset_token
  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
  # Returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
    
  # Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remember user in database for persistent session
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if given token matches digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Sets password reset attribute
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), 
                   reset_sent_at: Time.zone.now)
  end
  
  # Sends password reset email
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Returns true if password has expired
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  # Shows all books on user's wish list
  def reading_list
    books
  end
  
  # Adds book to user's reading list
  def add_to_list(book)
    relationships.create(book_id: book.id)
  end
  
  # Removes book from reading list
  def remove_from_list(book)
    relationships.find_by(book_id: book.id).destroy
  end
  
  # Returns true if book is on user's list
  def on_list?(book)
    books.include?(book)
  end
  
  private
  
    # Converts email to all lower case
    def downcase_email
      self.email = email.downcase
    end
end
