class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :show, :update, :destroy, :move_to_index]
  before_action :move_to_index, except: [:index, :show, :new, :create]

  def index
    @items = Item.all.order('created_at DESC')

    # @item = Item.find(params[:id])
    # @order_address = @item.order_address
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    return if user_signed_in? && current_user.id == @item.user_id && @item.order.nil?

    # ※学習用※　Rubocop実施後に、unlessからreturn if へと修正された
    redirect_to action: :index
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
