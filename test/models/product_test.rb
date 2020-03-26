require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "products attribute must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end
  test "product price must be positive" do
    product = Product.new(title:'test title',
                          description:'test description',
                          image_url:'test url.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(url)
    Product.new(title: 'test title',
                description: 'test description',
                price:1,
                image_url: url)
  end

  test 'image url' do
    ok = %w(hello.jpg bye.png http://gifs.com/tata.gif)
    bad = %w(hello.more bye.jiff http://fifs.com/tata.fiff)

    ok.each do |url|
      assert new_product(url).valid?, "#{url} shouldn't be invalid"
    end

    bad.each do |url|
      assert new_product(url).invalid?, "#{url} shouldn't be valid"
    end
  end
end
