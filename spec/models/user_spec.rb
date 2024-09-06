require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    
    context '新規登録できるとき' do

      it '必要な情報を適切に入力して「会員登録」ボタンを押すと、ユーザーの新規登録ができる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do

      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは半角英字だけでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password  is invalid. Include both letters and numbers")
      end
      it 'passwordは半角数字だけでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password  is invalid. Include both letters and numbers")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'お名前(全角)の名字は、空では登録できない' do
        @user.last_name_zenkaku = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name zenkaku can't be blank")
      end
      it 'お名前(全角)の名前は、空では登録できない' do
        @user.first_name_zenkaku = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name zenkaku can't be blank")
      end
      it 'お名前(全角)の名字は、全角以外では登録できない' do
        @user.last_name_zenkaku = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name zenkaku  is invalid. Input full-width characters")
      end
      it 'お名前(全角)の名前は、全角以外では登録できない' do
        @user.first_name_zenkaku = 'Rikutarou'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name zenkaku  is invalid. Input full-width characters")
      end
      it 'お名前(カナ全角)の名字は、空では登録できない' do
        @user.last_name_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana can't be blank")
      end
      it 'お名前(カナ全角)の名前は、空では登録できない' do
        @user.first_name_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana can't be blank")
      end
      it 'お名前(カナ全角)の名字は、カナ全角以外では登録できない' do
        @user.last_name_katakana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name katakana  is invalid. Input full-width characters")
      end
      it 'お名前(カナ全角)の名前は、カナ全角以外では登録できない' do
        @user.first_name_katakana = 'りくたろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name katakana  is invalid. Input full-width characters")
      end
      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end