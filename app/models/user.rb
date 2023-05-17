class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :account
  accepts_nested_attributes_for :account

  after_initialize :set_account

  private

  def set_account
    # see 'build_association', http://apidock.com/rails/ActiveRecord/Associations/ClassMethods/has_one
    build_account unless account.present?
  end
end
