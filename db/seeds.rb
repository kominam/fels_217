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
  category = Category.create! name: name
  5.times do |w|
    word_content = "word #{w+1} - category #{n+1}"
    word = Word.create content: word_content,
      category_id: category.id,
      answers_attributes: {
        0 => {
          content: "answer 1 - word #{w+1}",
          is_correct: false,
          word_id: w+1
        },
        1 => {
          content: "answer 2 - word #{w+1}",
          is_correct: false,
          word_id: w+1
        },
        2 => {
          content: "answer 3 - word #{w+1}",
          is_correct: false,
          word_id: w+1
        },
        3 => {
          content: "answer 4 - word #{w+1}",
          is_correct: true,
          word_id: w+1
        }
      }
  end
end
