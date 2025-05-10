class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  validates :external_id, presence: true, uniqueness: true
  validates :placed_at, presence: true
end