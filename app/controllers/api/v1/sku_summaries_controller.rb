class Api::V1::SkuSummariesController < ApplicationController
  def show
    stats = SkuStats.where(sku: params[:sku]).order(:week)
    summary = stats.map {|s| {week: s.week, total_quantity: s.total_quantity}}

    render json: { sku: params[:sku], summary: summary }
  end
end