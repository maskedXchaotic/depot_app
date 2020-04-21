class Category < ApplicationRecord
  belongs_to :parent, class_name: :Category, optional: true
  validates :name, uniqueness: {scope: :parent_id, case_sensitive: false}
  has_many :sub_categories, class_name: :Category, foreign_key: :parent_id, dependent: :destroy
  has_many :products, dependent: :restrict_with_error

  validate :ensure_depth_is_one, if: proc { |record| record.sub_category? } 

  def root_category?
    parent.nil?
  end

  def sub_category?
    !root_category?
  end

  def ensure_depth_is_one
    if parent.sub_category?
      throw :abort
    end
  end

  def self.list
    self.all.collect { |c| [ c.name, c.id ] }
  end
end
