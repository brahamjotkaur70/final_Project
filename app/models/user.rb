class User < ApplicationRecord
# Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #has_secure_password
  has_many :products


    validates_presence_of :firstname, :lastname, :email
    validates :email, uniqueness: true

end
