json.array! @orders do |order|

  json.id order.id

  json.product do
    json.id order.product.id
    json.name order.product.name
    json.color order.product.color
    json.description order.product.description
  end

  json.user order.user.email

  json.subtotal order.subtotal
  json.tax order.tax
  json.total order.total
end