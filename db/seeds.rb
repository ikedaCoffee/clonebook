100.times do |n|
  email = Faker::Internet.email
  name = "name#{n+1}"
  password = "password"
  User.create!(
    email: email,
    name: name,
    password: password,
    password_confirmation: password,
  )
end