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
open_lib_keys = ["/works/OL468431W", "/works/OL468431W", "/works/OL23205W", 
                 "/works/OL23204W"]
isbn_codes = ["9780191647253", "9780316769174", 
              "9784871878999", "9781440633904"]
image_ids = ["3169298", "6790237", "6790237", "6783900"]
publish_years = [1920, 1945, 1939, 1937]

titles.each_with_index do |title, idx|
  author = authors[idx]
  isbn = isbn_codes[idx]
  thumbnail_url = "https://covers.openlibrary.org/b/id/" + 
                  image_ids[idx] + "-S.jpg"
  openlibrary_key = open_lib_keys[idx]
  first_publish_year = publish_years[idx]
  Book.create!(title: title, author: author, isbn: isbn, 
               thumbnail_url: thumbnail_url, openlibrary_key: openlibrary_key, 
               first_publish_year: first_publish_year)
end

# Book listing relationships
user = User.first
books = Book.all
books.each { |book| user.add_to_list(book) }