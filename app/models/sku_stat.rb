class SkuStat < ApplicationRecord
  validates :sku, presence: true
  validates :week, presence: true
  validates :total_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :sku, uniqueness: {scope: :week}
end