json.array! @products do |product|

  json.id product.id

  json.name product.name
  json.description product.description

  json.price product.price
  json.percent_off product.on_sale
  json.total product.total


  json.in_stock product.in_stock

  json.categories product.categories
  json.supplier product.supplier
  json.images product.images


  json.color product.color
  json.material product.material

  weight, sfx = (product.weight * 0.035274), "oz."

  if weight > 30
    weight, sfx = (product.weight * 0.00220462), "lbs."
  end
  weight = weight.round(2)

  json.weight "#{weight} #{sfx}"
  json.origin product.country_of_origin
end
  


