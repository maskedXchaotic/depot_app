
class Product < ApplicationRecord
  belongs_to :categoryable, polymorphic: true
  has_many :orders , through: :line_items
  has_many :line_items, dependent: :restrict_with_error
  has_many :carts, through: :line_items

  after_commit :set_category_product_count

  before_destroy :ensure_not_referenced_by_any_line_item

  scope :enabled, -> { where(enabled: true) }
  #...

  validates :title, :description, :image_url, presence: true
# 
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, length: {minimum: 10}
  validates :permalink, uniqueness: true, format: {with: /\A[a-zA-Z0-9\- ]+\z/}

  validates_length_of :words_in_description, minimum: 5, maximum: 10
  validates_length_of :words_in_permalink, minimum: 3

  validates :price, numericality: {greater_than_or_equal_to: :discount_price}
  validates :discount_price, numericality: {greater_than_or_equal_to: 0.01}, allow_blank:true
  # validate :price_greater_than_discount_price

  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items present')
        throw :abort
      end
    end
    
    def words_in_description
      description.scan(/\w+/)
    end
    
    def words_in_permalink
      permalink.split('-')
    end

    def self.present_in_atleast_one_lineitem
      self.joins(:line_items).distinct
    end

    def self.titles_in_array
      self.present_in_atleast_one_lineitem.pluck(:title)
    end

    def set_category_product_count
      if self.categoryable.instance_of? Category
        category = self.categoryable
      elsif self.categoryable.instance_of? SubCategory
        category = self.categoryable.category
      end
      category.products_count = category.products.count + category.sub_categories.inject(0) {|a,b| a+= b.products.count}
      category.save
    end

end
