FactoryBot.define do
  factory :plane do
    model { Faker::Name.name }
    registration { Faker::Name.name }
    description { Faker::Name.name }
    cruise_speed { '100' }
    tour_price { '200' }
    picture { 'picture.com'}
  end
end
