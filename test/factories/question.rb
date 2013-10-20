FactoryGirl.define do
  factory :question do
    sequence(:question_text) { Faker::Lorem.paragraph }
  end
end
