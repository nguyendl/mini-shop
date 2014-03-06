FactoryGirl.define do
  factory :user do
    
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email( first_name + last_name ) }
    birthdate  { 23.years.ago }
    password   { Faker::Lorem.characters(20) }
  end
end