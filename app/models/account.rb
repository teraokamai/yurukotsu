class Account < ApplicationRecord
  has_many :record, dependent: :destroy
  has_one :category, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # def self.find_first_by_auth_conditions(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     # 認証の条件式を変更する
  #     where(conditions).where(['email = :value', { value: email }]).first
  #   else
  #     where(conditions).first
  #   end
  # end
end
