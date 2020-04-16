class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products, as: :categoryable, dependent: :restrict_with_error
  validates :name, uniqueness: {scope: :category_id}
end
