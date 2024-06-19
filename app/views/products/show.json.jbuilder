json.id @data['id']
json.name @data['name']


json.price @data['price']
json.percent_off @data['on_sale']

json.after_tax @data['total']
json.initial_total @data['initial_price']

json.in_stock @data['in_stock']

json.categories @data['categories']
json.description @data['description']
json.color @data['color']
json.material @data['material']

weight, sfx = (@data['weight'] * 0.035274), "oz."

if weight > 30
  weight, sfx = (@data['weight'] * 0.00220462), "lbs."
end
weight = weight.round(2)

json.weight "#{weight} #{sfx}"
json.origin @data['country_of_origin']

json.supplier @data['supplier']
json.images @data['images']
