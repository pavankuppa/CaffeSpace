json.orders do
  json.array! @orders do |order_number, order_items|
    json.order_number order_number
    json.order_price order_items[0].order_price
    json.status order_items[0].status
    json.order_at order_items[0].created_at
    items = order_items.group_by(&:offer_name)
    json.order_items do
      json.array! items do |offer_name, _items|
        json.offer_name offer_name if offer_name
        json.offer_type _items[0].offer_type if offer_name
        json.discount_percentage _items[0].discount_percentage if _items[0].offer_type == Offer::DISCOUNT
        json.items do
          json.array! _items do |it|
            json.item_name it.item_name
            json.quantity it.quantity
            json.price it.price
            json.free it.free if it.free
          end
        end
      end
    end
  end
end
