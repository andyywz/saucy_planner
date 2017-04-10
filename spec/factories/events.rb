FactoryGirl.define do
  factory :event do
    name { Faker::LordOfTheRings.location }
    date { Faker::Date.between(1.year.ago, 1.year.from_now) }
    description { Faker::Friends.quote }
    user_id nil

    transient do
      attendees_count 5
    end

    factory :event_with_attendees do
      after(:create) do |event, evaluator|
        (0...evaluator.attendees_count).each do |i|
          event.people << FactoryGirl.create(:person)
        end
      end
    end
  end
end
