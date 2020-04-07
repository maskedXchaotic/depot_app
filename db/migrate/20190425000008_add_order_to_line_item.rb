
class AddOrderToLineItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :line_items, :order, null: true, foreign_key: true
    remove_foreign_key :line_items, :carts
    change_column :line_items, :cart_id, :bigint, null: true
    add_foreign_key :line_items, :carts
  end
end
