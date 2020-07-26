require 'faker'

User.transaction do
  unless User.find_by(email: 'admin@admin.com', role: User.roles[:admin])
    User.create!(
      email: 'admin@admin.com',
      role: User.roles[:admin],
      password: 'password',
      password_confirmation: 'password'
    )
  end

  30.times do |index|
    User.create!(
      email: "user-#{index}@gmail.com",
      role: index % 5 == 0 ? User.roles[:admin] : User.roles[:customer],
      password: 'password',
      password_confirmation: 'password'
    )
  end

  10.times do
    account = User.customer.to_a.sample
    Payment.create!(
      amount_in_cents: Faker::Number.between(from: 1, to: 100000),
      currency: :usd,
      account_id: account.id,
      purpose: Faker::Lorem.word,
      creator: User.take,
      updater: User.take
    )
  end
end
