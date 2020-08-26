class Product < ApplicationRecord
   has_one_attached :avatar
   belongs_to :category

end
