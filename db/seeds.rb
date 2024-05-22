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

names = []
30.times do
  name = generator.brand
  if names.include?(name)
    next
  end
  names.push(name)
  email = "products@#{name.gsub(/\s+/, "")}.org"
  phone = Faker::Base.numerify('###-###-####')
  supp = Supplier.new(name: name, email: email, phone_number: phone)
  if supp.valid?
    supp.save
  end
end

supp_limit = Supplier.all.length

200.times do
  name = generator.product_name
  price = (generator.price(range:99...3000)).to_i
  dep = generator.department(max: 3)
  
  deps = dep.split(/, | & /)
  num = rand(60)
  if num > 40
    sale = rand(0...45)
  else
    sale = 0
  end
  url1 = "https://#{name.gsub(/\s+/, "")}_product_image.jpeg".downcase
  url2 = "https://#{name.gsub(/\s+/, "")}_product_image2.jpeg".downcase
  url3 = "https://#{name.gsub(/\s+/, "")}_product_image3.jpeg".downcase

  stock = rand(0...40)

  supp_id = rand(1..supp_limit)
  brand = nil
  brand = Supplier.find_by(id: supp_id).name

  color, material, country = generator.color, generator.material, Faker::Address.country

  grams = rand(15..18000)

  if brand
    desc = "This #{color} #{name}, developed by #{brand}, was made in #{country} using only the finest #{material}!"
  end

  prod = Product.new(name: name, price: price, categories: deps, on_sale: sale, in_stock: stock, description: desc, color: color, supplier_id: supp_id, material: material, country_of_origin: country, weight: grams)

  if prod.valid?
    prod.save

    for url in [url1, url2, url3]
      img = Image.new(url: url, product_id: prod.id)
      if img.valid?
        img.save
      else
        pp img.errors
      end
    end
  else
    pp prod.errors
  end
end




