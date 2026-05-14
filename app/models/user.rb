class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  enum :role, { normal: 0, admin: 1 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  has_many :tasks
end
