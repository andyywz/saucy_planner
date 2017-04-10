# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  first_name, last_name = Faker::Name.first_name, Faker::Name.last_name
  u = User.create!({
    first_name: first_name,
    last_name: last_name,
    email: Faker::Internet.safe_email(first_name),
    login: Faker::Internet.user_name(first_name)
  })
  puts "user created #{u}"
end

20.times do
  User.first.events.create!({
    name: Faker::HarryPotter.character,
    date: Faker::Date.between(1.week.ago, 1.week.from_now),
    description: Faker::HarryPotter.location
  })
end
