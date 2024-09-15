class Address < ApplicationRecord

  belongs_to :order

  # validates :post_code,        presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  # validates :city,             presence: true
  # validates :house_number,     presence: true
  # validates :telephone_number, presence: true

  ## ジャンルの選択が「---」の時は保存できないようにする
  # validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

end
