class User < ApplicationRecord
    has_secure_password
  
  
    validates_presence_of :firstname, :lastname, :email
    validates :email, uniqueness: true
 
end
