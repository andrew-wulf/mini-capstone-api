json.id @user.id

json.name @user.name
json.email @user.email

json.admin @user.admin

cart_size = 0
json.cart do
  json.array! @user.cart do |item|
    json.id item.id

    json.quantity item.quantity
    cart_size += item.quantity

    json.product do
      json.id item.product.id

      json.name item.product.name
      json.description item.product.description

      json.price item.product.price
      json.on_sale item.product.on_sale
      json.total item.product.total
    end

    json.images item.product.images
  end
end

if @user.cart.length > 0
  json.cart_size cart_size
  json.cart_totals @user.cart_totals
end

json.orders do
  json.array! @user.orders do |order|
    json.id order.id

    json.subtotal order.subtotal
    json.tax order.tax
    json.total order.total
    json.date order.created_at

    json.products do
      json.array! order.carted_products do |cp|
        json.product_id cp.product.id
        json.name cp.product.name
        json.quantity cp.quantity
        json.cp_id cp.id
        json.status cp.status
      end
    end
  end
end