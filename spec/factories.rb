FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Vladimir Vladimirovich vol. #{n}" }
    sequence(:email) { |n| "one_one_#{n}@kremlin.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end

  end
end