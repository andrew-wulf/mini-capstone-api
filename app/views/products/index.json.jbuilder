json.array! @products do |prod|

  data = prod.display

  json.id data['id']
  json.name data['name']


  json.price data['price']

  if data['on_sale'] > 0
    json.on_sale "#{data['on_sale']}%"
  end

  json.total data['total']
  json.initial_price data['initial_price']


  json.categories data['categories']
  json.description data['description']
  json.color data['color']
  json.material data['material']

  weight, sfx = (data['weight'] * 0.035274), "oz."

  if weight > 30
    weight, sfx = (data['weight'] * 0.00220462), "lbs."
  end
  weight = weight.round(2)

  json.weight "#{weight} #{sfx}"

  json.supplier data['supplier']
  json.images data['images']
end
  


