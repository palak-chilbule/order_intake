# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

order1 = Order.create!(
  external_id: "SAP-ORDER-1001",
  placed_at: 2.days.ago
)

order1.line_items.create!(sku: "SKU123", quantity: 10)
order1.line_items.create!(sku: "SKU456", quantity: 5)

order1.update!(created_at: 10.minutes.ago)
order1.line_items.update_all(original: false)
order1.line_items.create!(sku: "SKU123", quantity: 8, original: true)
order1.line_items.create!(sku: "SKU456", quantity: 6, original: true)

order2 = Order.create!(
  external_id: "SAP-ORDER-1002",
  placed_at: 3.days.ago,
  locked_at: Time.current
)

order2.line_items.create!(sku: "SKU123", quantity: 7)
# SkuStatJob.perform_now(["SKU123", "SKU456"])
