class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :house_number,
                :building_name, :telephone_number, :order_id,
                :item_id, :user_id , :token


    with_options presence: true do
      validates :city
      validates :house_number
      # validates :order_id
      validates :item_id
      validates :user_id
      validates :token
    end


    validates :telephone_number, format: {with: /\A[0-9]{11}\z/, message: "is invalid. Except hyphen(-)"}
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }


    def save
      # 購入を保存し、変数orderに代入する
      order = Order.create(item_id: item_id, user_id: user_id)
      # 住所を保存する
      # order_idには、変数orderのidと指定する
      Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, telephone_number: telephone_number, order_id: order.id)
    end


    # 各モデルのbelongs toはここでは通用しないので再入力！
    # 上記に基づき、各モデルのバリデーションは重複するので削除すること！

end