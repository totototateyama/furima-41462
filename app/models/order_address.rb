class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :house_number,
                :building_name, :telephone_number, :order_id,
                :item_id, :user_id , :token

    with_options presence: true do
      validates :city
      validates :house_number
      validates :item_id
      validates :user_id
      validates :token
    end

    validates :telephone_number, format: {with: /\A[0-9]{10,11}\z/, message: "is invalid. Except hyphen(-)"}
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

    def save
      order = Order.create(item_id: item_id, user_id: user_id)
      Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, telephone_number: telephone_number, order_id: order.id)
    end

end