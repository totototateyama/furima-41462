class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  validates :nickname, presence: true
  # validates :first_name_zenkaku, presence: true
  # validates :last_name_zenkaku, presence: true
  # validates :first_name_katakana, presence: true
  # validates :last_name_katakana, presence: true
  validates :birthday, presence: true

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: ' is invalid. Input full-width characters' } do
    validates :first_name_zenkaku
    validates :last_name_zenkaku
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ一]+\z/, message: ' is invalid. Input full-width characters' } do
    validates :first_name_katakana
    validates :last_name_katakana
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: ' is invalid. Include both letters and numbers'
end
