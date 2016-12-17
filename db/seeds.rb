User.create!(user_name: "Administrator",
  email: "admin@gmail.com",
  password: "foobar",
  password_confirmation: "foobar",
  is_admin: true)

10.times do |n|
  user_name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "1234567890"
  User.create!(user_name: user_name,
    email: email,
    password: password,
    password_confirmation: password)
end

10.times do |n|
  name  = "Category #{n+1}"
  description = "Description #{n+1}"
  Category.create! name: name
end
