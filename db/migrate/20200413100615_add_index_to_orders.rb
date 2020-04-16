class AddIndexToOrders < ActiveRecord::Migration[6.0]
  def change
    add_index :orders, :user_id
    add_foreign_key :orders, :users
  end
end
