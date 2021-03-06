FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email() }
    login { Faker::Internet.user_name() }
    admin true
  end
end
