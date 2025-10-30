FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    post { association :post }
  end
end
