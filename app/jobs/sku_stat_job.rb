class SkuStatJob < ApplicationJob
  queue_as :default =>  value

  def perform(skus)
    skus.uniq.each do |sku|
      1.upto(4) do |i|
        start_time = i.weeks.ago.beginning_of_week
        end_time = (i-1).weeks.ago.beginning_of_week
        week_str = start_time.strftime("%G-W%V")

        orders = Order.where(placed_at: start_time...end_time)

        latest_ids = LineItem.joins(:order).where(order: orders, sku: sku, original: true).group(:order_id).maximum(:id).values

        total_quantity = LineItem.where(id: latest_ids).sum(:quantity)

        SkuStat.upsert(
          {
            sku: sku,
            week: week_str,
            total_quantity: total_quantity,
            updated_at: Time.current
          },
          unique_by: [:sku, :week]
        )
      end
    end
  end
end
