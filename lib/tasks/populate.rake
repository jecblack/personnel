namespace :loader do
  require 'faker'
  desc "Erase and fill datbase with fake records"
  task populate: :environment do
    Person.destroy_all
    100.times do |n|
      big_name  = Faker::Name.name
      split = big_name.split(' ',2)
      first_name = split[0]
      name = split[1]
      address = Faker::Address.street_address
      email = "example-#{n+1}@gmail.com"
      tel = Faker::PhoneNumber.phone_number
      city = Faker::Address.city
      state   = Faker::Address.state_abbr
      zip     = Faker::Address.zip
      Person.create!( first_name: first_name, name: name,  address: address,  tel: tel, email: email, city: city, state: state, zip: zip)
    end
  end
end