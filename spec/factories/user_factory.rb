FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    role { :admin }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
