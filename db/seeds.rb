User.create!(name:  "Example User",
             email: "user@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@user.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)

titles = ['The Great Gatsby', 'The Catcher in the Rye', 'Grapes of Wrath',
          'Of Mice and Men']
authors = ['F. Scott Fitzgerald','Robert B. Kaplan', 'Boyd Cable', 
           'John Steinbeck']
isbn_codes = ["9780191647253", "9780316769174", 
              "9784871878999", "9781440633904"]
image_ids = ["3169298", "6790237", "6790237", "6783900"]

titles.each_with_index do |title, idx|
  author = authors[idx]
  isbn = isbn_codes[idx]
  thumbnail_url = "https://covers.openlibrary.org/b/id/" + 
                  image_ids[idx] + "-S.jpg"
  Book.create!(title: title, author: author, isbn: isbn, 
               thumbnail_url: thumbnail_url)
end

# Book listing relationships
user = User.first
books = Book.all
books.each { |book| user.add_to_list(book) }