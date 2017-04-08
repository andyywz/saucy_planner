FactoryGirl.define do
  factory :event do
    name { Faker::LordOfTheRings.location }
    date { Faker::Date.between(1.year.ago, 1.year.from_now) }
    description { Faker::Friends.quote }
    user_id nil
  end
end
