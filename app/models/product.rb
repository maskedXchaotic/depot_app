
class Product < ApplicationRecord
  has_many :line_items
  has_many :orders , through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  #...

  validates :title, :description, :image_url, presence: true
# 
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, length: {minimum: 10}
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true
  validates :permalink, uniqueness: true, format: {with: /\A[a-zA-Z0-9\- ]+\z/}

  validate :description_word_length
  validate :permalink_word_length

  validates :price, numericality: {greater_than_or_equal_to: :discount_price}
  # validate :price_greater_than_discount_price

  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items present')
        throw :abort
      end
    end
    
    def description_word_length
      word_length = description.split.length
      errors.add(:base, 'description must have at least 5 words') if word_length < 5
      errors.add(:base, 'description must have at most 10 words') if word_length > 10
    end
    
    def permalink_word_length
      word_length = permalink.split('-').length
      errors.add(:base, "permalink must have at least 3 words seperated by '-'") if word_length < 3
    end

end
