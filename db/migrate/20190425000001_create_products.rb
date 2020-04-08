class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.decimal :price, precision: 8, scale: 2
      t.boolean :enabled, default: false
      t.decimal :discount_price, precision: 8, scale: 2
      t.string :permalink

      t.timestamps
    end

    # Irreverise migration
    # uncomment to run it
    # execute <<~SQL
    #   ALTER TABLE products
    #     ADD CONSTRAINT discount_price_check
    #       CHECK (discount_price <= price);
    # SQL
  end
end
