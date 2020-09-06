# Factory.define :provider do |provider|
#   provider.sequence(:name) { |n| "mike#{n}"}
#   provider.sequence(:email) { |n| "provider#{n}@support.com"}
#   provider.lowest_price rand(200..500)
#   provider.rating rand(2.0..5.0).round(2)
#   provider.max_speed rand(1..12).round(2)
#   provider.description "is simply dummy text of the printing and typesetting industry."
#   provider.contact_no rand(10**10)
#   provider.sequence(:url) { |n| "http://www.provider#{n}.com"}
# end

FactoryBot.define do
  factory :provider do
    name { Faker::Name.unique }
    email { Faker::Internet.email }
    lowest_price {rand(200..500)}
    rating {rand(2.0..5.0).round(2)}
    max_speed {rand(1..12).round(2)}
    description = "is simply dummy text of the printing and typesetting industry."
    contact_no {rand(10**10)}
    url { Faker::Internet.url }
  end
end