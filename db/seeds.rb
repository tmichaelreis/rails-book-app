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

50.times do
  rand_book = Faker::Number.between(0,3)
  title = titles[rand_book]
  author = authors[rand_book]
  isbn = isbn_codes[rand_book]
  thumbnail_url = "https://covers.openlibrary.org/b/id/" + 
                  image_ids[rand_book] + "-S.jpg"
  users.each do |user| 
    user.books.create!(title: title, author: author, isbn: isbn, 
                       thumbnail_url: thumbnail_url)
  end
end