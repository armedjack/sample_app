FactoryGirl.define do
  factory :user do
    name     "Vladimir Vladimirovich"
    email    "one@kremlin.com"
    password "foobar"
    password_confirmation "foobar"
  end
end