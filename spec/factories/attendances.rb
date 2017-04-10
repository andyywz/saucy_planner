FactoryGirl.define do
  factory :attendance do
    association :person
    association :event
  end
end
