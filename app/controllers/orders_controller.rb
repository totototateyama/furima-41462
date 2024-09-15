class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end


  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.valid?
      pay_item
       @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end


  private
  def order_address_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, 
                  :house_number, :building_name, :telephone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end


  def move_to_index
    @item = Item.find(params[:item_id])
   if @item.order != nil || current_user.id == @item.user_id
    redirect_to root_path
   else
   end
  end


  def pay_item
    @item = Item.find(params[:item_id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_address_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end


end
