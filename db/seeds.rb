# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



generator = Faker::Commerce

50.times do
  name = generator.product_name
  price = (generator.price(range:99...3000)).to_i
  dep = generator.department(max: 3)
  
  deps = dep.split(/, | & /)
  deps = deps.join(', ')

  num = rand(60)
  if num > 40
    sale = rand(0...45)
  else
    sale = 0
  end
  url = nil

  stock = rand(0...40)

  desc = "This #{generator.color} #{name}, developed by #{generator.brand}, was made in #{Faker::Address.country} using only the finest #{generator.material}!"


  prod = Product.new(name: name, price: price, category: deps, on_sale: sale, image_url: nil, in_stock: stock, description: desc)
  if prod.valid?
    prod.save
  end
end




10.times do
  name = generator.unique.brand
  email = "products@#{name.gsub(/\s+/, "")}.org"
  phone = Faker::Base.numerify('###-###-####')
  supp = Supplier.new(name: name, email: email, phone_number: phone)
  if supp.valid?
    supp.save
  end
end