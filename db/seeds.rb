# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(email: "jim@jecblack.com", password: "4kil8mar", password_confirmation: "4kil8mar", role: :admin)
puts 'CREATED ADMIN USER: ' << user.email
