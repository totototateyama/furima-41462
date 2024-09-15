class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index

  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end


  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
       @order_address.save
      redirect_to root_path
    else
    @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end


  private
  def order_address_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, 
                  :house_number, :building_name, :telephone_number).merge(item_id: params[:item_id], user_id: current_user.id)
                  # :item_id, :user_id, :order_id
  end


  def move_to_index
    @item = Item.find(params[:item_id])
   if @item.order != nil
    # elsif current_user.id == @item.user_id

    redirect_to root_path

   else

  end
end
end
