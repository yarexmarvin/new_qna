FactoryBot.define do
  factory :answer do
    association :question

    body { "MyAnswer" }

    trait :invalid do
      body { nil }
    end
  end
end
