class AddSuppliers < ActiveRecord::Migration[7.1]
  def change
    for prod in Product.all
      prod.suppliers_id = rand(1..Supplier.all.length)
      if prod.valid?
        prod.save
      else
        pp prod.errors
      end
    end
  end
end
