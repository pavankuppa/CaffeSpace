class CreateOrderService

  def initialize(order_params)
    @variant_ids            = order_params[:variants] # hold variant id's
    @offer_ids              = order_params[:offers] # hold offer id's
    @order_items_attributes = []
    @order_price            = 0
  end

  def build
    build_order_item_from_variant if @variant_ids
    build_order_item_from_offers if @offer_ids
    @order = Order.new(order_price: @order_price)
    @order.order_items.build(@order_items_attributes)
  end

  private

  # build order item objects from variants model
  def build_order_item_from_variant
    if @variant_ids

      # for each variants get item name, quantity and price, and to calculate total price of an order
      Variant.find(@variant_ids).each do |variant|
        @order_price+=variant.price
        @order_items_attributes << build_item_variant(variant)
      end
    end
  end

  # build order item objects from offer model
  def build_order_item_from_offers
    if @offer_ids

      # iterate offers (dicounts & free) and to calculate total price of an order

      Offer.find(@offer_ids).each do |offer|
        offer_type = offer.offer_type
        offer.offer_items.each do |offer_item|
          offer_attributes = {
            offer_name: offer.name,
            offer_type: offer_type
          }

          variant = offer_item.variant
          price = variant.price
          offer_attributes.merge!(build_item_variant(variant))
          if offer_type == Offer::DISCOUNT
            offer_attributes.merge!({ discount_percentage: offer.discount_percentage })
            @order_price+=variant.discounted_price(offer.discount_percentage)
          else
            @order_price+=price unless offer_item.free
            offer_attributes.merge!({ free: true })
          end
          @order_items_attributes << offer_attributes
        end
      end
    end
  end

  def build_item_variant(variant)
    {
      item_name: variant.item.name,
      quantity: variant.quantity,
      price: variant.price
    }
  end

end
