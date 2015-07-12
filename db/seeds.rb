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

isbn_codes = ["9780191647253", "9780316769174", 
              "9784871878999", "9781440633904"]
50.times do
  isbn = isbn_codes[Faker::Number.between(0,3)]
  rating = Faker::Number.between(1, 5)
  review = Faker::Lorem.sentence(5)
  users.each do |user| 
    user.books.create!(isbn: isbn, rating: rating, review: review)
  end
end