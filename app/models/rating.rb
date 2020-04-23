class Rating < ApplicationRecord
 belongs_to :product
 validates :value, numericality: {min: 1, max: 5}
 validates :user_id, uniqueness: {scope: :product_id}
end