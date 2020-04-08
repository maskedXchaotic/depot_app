
class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true
  validates :cart, uniqueness: {scope: :product}


  def total_price
    product.price * quantity
  end
end
