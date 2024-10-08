FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name_zenkaku    { '陸太郎' }
    last_name_zenkaku     { '山田' }
    first_name_katakana   { 'リクタロウ' }
    last_name_katakana    { 'ヤマダ' }
    birthday              { Faker::Date.birthday }
  end
end
