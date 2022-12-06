json.offers do
  json.array! @offers do |offer_name, offers|
    price = 0
    json.name offer_name
    if offers[0]
      json.offer_id offers[0].offer_id
      json.discount_percentage offers[0].discount_percentage
    end
    json.items do
      json.array! offers do |offer|
        json.item_name offer.item_name
        json.quantity offer.quantity
        json.price offer.price
        price+=offer.price if !offer.free
      end
    end
    json.price price.to_f
    json.discounted_price (price - price * offers[0].discount_percentage/100).to_f
  end
end
