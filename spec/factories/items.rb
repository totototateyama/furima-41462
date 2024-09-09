FactoryBot.define do
  factory :item do

    item_name              { Faker::Lorem.characters(number: 40) }
    description            { Faker::Lorem.characters(number: 1000) }
    category_id            { '2' }
    condition_id           { '2' }
    shipping_cost_id       { '2' }
    prefecture_id          { '2' }
    shipping_day_id        { '2' }
    price                  { Faker::Number.between(from: 300, to: 9_999_999) }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    
  end
end
