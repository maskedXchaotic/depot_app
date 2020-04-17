class Category < ApplicationRecord
  belongs_to :parent, class_name: :Category, optional: true
  validates :name, uniqueness: {scope: :parent_id, case_sensitive: false}
  has_many :sub_categories, class_name: :Category, foreign_key: :parent_id, dependent: :destroy
  has_many :products, dependent: :restrict_with_error

  validate :ensure_depth_is_one, if: -> { |record| record.sub_category? } 

  def root_category?
    parent.nil?
  end

  def sub_category?
    !category?
  end

  def ensure_depth_is_one
    unless parent.parent.nil?
      throw :abort
    end
  end
end
