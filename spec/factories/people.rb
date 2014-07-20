# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name "Volunteer"
    first_name "A."
    email "test@example.com"
    address "123 Some Street"
    city "Anywhere"
    state "CA"
    zip "12345"
    tel "(925) 555-1234"
  end
end
