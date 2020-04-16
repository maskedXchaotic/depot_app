class Category < ApplicationRecord
  belongs_to :parent, class_name: :Category, optional: true
  validates :name, uniqueness: {scope: :parent_id}
  has_many :sub_categories, class_name: :Category, foreign_key: :parent_id, dependent: :destroy
  has_many :products, dependent: :restrict_with_error

  validate :ensure_depth_is_one

  def category?
    self.parent.nil?
  end

  def sub_category?
    !self.category?
  end

  def ensure_depth_is_one
    unless self.parent.parent.nil?
      throw :abort
    end
  end
end
