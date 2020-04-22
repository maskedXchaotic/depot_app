class Counter < ApplicationRecord
  belongs_to :user
  validates :url, presence: true, uniqueness: { scope: :user_id }
  validates :count, numericality: {min: 0}
end