# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do

  user = User.create(name: Faker::Name.first_name, email: Faker::Internet.email, password: 'password', password_confirmation: 'password')

  5.times do
    Post.create(content: Faker::Hacker.say_something_smart, user_id: user.id)
  end

end
