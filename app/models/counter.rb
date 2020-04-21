class Counter < ApplicationRecord
  belongs_to :user
  validates :url, presence: true
  validates :count, numericality: {min: 0}
end