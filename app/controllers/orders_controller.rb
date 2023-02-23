class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show update destroy ]

  # GET /orders
  def index
    @orders = Order.joins(:order_items).order("orders.id DESC").select(select_column_names).group_by(&:order_number)
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = CreateOrderService.new(order_params).build
    if @order.save
      OrdersJob.set(wait: 1.minutes).perform_later(@order)
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(variants: [], offers: [])
    end

    def select_column_names
      "
        orders.id,
        orders.order_number,
        orders.order_price,
        order_items.item_name,
        order_items.offer_name,
        order_items.offer_type,
        order_items.discount_percentage,
        order_items.free,
        order_items.quantity,
        order_items.price,
        orders.created_at,
        orders.status
      "
    end
end
