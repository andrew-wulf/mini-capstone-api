class AddsupplierIdToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :suppliers, index: true
  end
end
