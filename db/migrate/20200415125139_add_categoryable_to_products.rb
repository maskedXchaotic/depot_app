class AddCategoryableToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :categoryable, polymorphic: true
  end
end
