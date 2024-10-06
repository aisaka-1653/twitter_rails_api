# frozen_string_literal: true

ApplicationRecord.transaction do
  10.times do |_n|
    user = User.new(
      email: Faker::Internet.unique.email,
      password: 123_456,
      display_name: Faker::Name.unique.first_name,
      username: Faker::Internet.unique.username,
      date_of_birth: Faker::Date.birthday
    )
    user.skip_confirmation!
    user.save!
    20.times do |_n|
      user.tweets.create!(
        content: Faker::Lorem.paragraph
      )
    end
  end
end
