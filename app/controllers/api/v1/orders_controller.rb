class Api::V1::OrdersController < ApplicationController
  before_action :set_order

  def create
    order_data = permitted_params
    order = @order
    if order
      if order.locked? 
        render json: { error: 'LockedForEdit' }, status: :unprocessable_entity and return
      end
      order.line_items.update_all(original: false)
    else
      order = Order.create!(external_id: params[:external_id], placed_at: params[:placed_at])
    end

    order_data[:line_items].each do |item|
      order.line_items.create!(sku: item[:sku], quantity: item[:quantity], original: true)
    end

    SkuStatJob.perform_later(order.line_items.pluck(:sku).uniq)
    render json: {id: order.id}, status: :ok
  end

  def lock
    order = Order.find_by(id: params[:id])
    if order.locked?
      render json: {error: 'AlreadyLocked'}, status: :unprocessable_entity and return 
    end

    order.update!(locked_at: Time.current)
    SkuStatJob.perform_later(order.line_items.pluck(:sku).uniq)
    render json: {status: 'Locked'}
  end

  private

  def permitted_params
    params.require(:external_id)
    params.require(:placed_at)
    params.require(:line_items)
    params.permit(
      :external_id, :placed_at, line_items: [:sku, :quantity]
    )
  end

  def set_order
    @order = Order.find_by(external_id: params[:external_id])
  end

  def locked?
    locked_at.present? || created_at < 15.minutes.ago
  end
end