
class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.integer :line_items_count, default: 0, null: false
      t.timestamps
    end
  end
end
