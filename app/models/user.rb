class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :nickname, presence: true
  validates :birthday, presence: true

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: ' is invalid. Input full-width characters' } do
    validates :first_name_zenkaku
    validates :last_name_zenkaku
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: ' is invalid. Input full-width characters' } do
    validates :first_name_katakana
    validates :last_name_katakana
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: PASSWORD_REGEX, message: ' is invalid. Include both letters and numbers'
end
