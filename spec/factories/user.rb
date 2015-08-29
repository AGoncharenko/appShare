FactoryGirl.define do
  sequence :email do |n|
    "#{Faker::Lorem.characters(8)}-#{n}@factory.com"
  end

  factory :user do
    email
    password "1#{Faker::Lorem.characters(7)}"
    factory :confirmed_user do
      confirmed_at 7.days.ago
    end

  end
end