desc "Set products with no category to first category"
task port_legacy_products: :environment  do
  category = Category.first
  Product.where(id: nil).find_in_batches do |products|
    products.each do |product|
      product.category = category
      product.save
    end
  end
end