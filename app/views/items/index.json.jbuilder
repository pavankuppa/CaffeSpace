json.items do
  json.array! @collections do |item|
    json.item_id item.item_id
    json.variant_id item.variant_id
    json.name item.name
    json.quantity item.quantity
    json.price item.price.to_f
  end
end
