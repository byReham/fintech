FactoryBot.define do
  factory :payment do
    association :account, factory: :user

    amount_in_cents { Faker::Number.between(from: 1, to: 100000) }
    currency { :usd }
    purpose { Faker::Lorem.word }
  end
end
