User.create!(name:  "Mohammad Tarek",
             email: "uname5000@gmail.com",
             password:              "12345678",
             password_confirmation: "12345678")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@mallakyapp.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
