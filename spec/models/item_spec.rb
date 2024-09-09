require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: user.id)
  end

  describe '商品の出品' do
    context '商品を出品できるとき' do
      it '必要な情報を適切に入力して「出品する」ボタンを押すと、商品情報がデータベースに保存される' do
        expect(@item).to be_valid
      end
    end

    context '商品を出品できないとき' do
      it '商品画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品の説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it '商品の詳細（カテゴリー）が空では登録できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の詳細（商品の状態）が空では登録できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料について（配送料の負担）が空では登録できない' do
        @item.shipping_cost_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost can't be blank")
      end
      it '配送料について（発送元の地域）が空では登録できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '配送料について（発送までの日数）が空では登録できない' do
        @item.shipping_day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it '販売価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格が300円以下では登録できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid')
      end
      it '販売価格が9,999,999円以上では登録できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid')
      end
      it '販売価格は全角数字を含むと登録できない' do
        @item.price = '１２３４５６'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid')
      end
      it 'user_idが紐づいていないと登録できない' do
        @item.user_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
