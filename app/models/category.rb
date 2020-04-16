class Category < ApplicationRecord
  has_many :products, as: :categoryable, dependent: :restrict_with_error
  validates :name, presence: true, uniqueness: true
  has_many :sub_categories, dependent: :destroy

end