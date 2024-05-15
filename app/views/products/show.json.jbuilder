json.current_item @product.name

factor = (100 - @product.on_sale)

price_int = (@product.price * factor) / 100
price = price_int.to_s
price = '$' + price[...-2] + '.' + price[-2...]

json.price price
if @product.on_sale > 0
  json.percent_off "#{@product.on_sale}%"
end
json.categories @product.category
json.image_url @product.image_url
json.description @product.description
json.id @product.id