class RenameSuppliers < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :suppliers_id, :index


    change_table :products do |t|
      t.belongs_to :suppliers, index: true, foreign_key: true
    end
  end
end
