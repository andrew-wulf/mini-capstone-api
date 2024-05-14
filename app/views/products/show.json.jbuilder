json.number_of_products @products.length

max, product = 0, ""
for p in @products
  if p.in_stock > max
    max, product = p.in_stock, p.name
  end
end

json.most_in_stock [product, max]

sale_items = {}
for p in @products
  if p.on_sale > 25
    sale_items[p.name] = ["$#{(p.price/100) * (1 - (p.on_sale/100))}", "#{p.on_sale}% off!", p.description, p.category]
  end
end


json.on_sale sale_items