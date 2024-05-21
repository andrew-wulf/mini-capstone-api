class Fix < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :suppliers_id, :index
    add_column :products, :supplier_id, :integer
  end
end
