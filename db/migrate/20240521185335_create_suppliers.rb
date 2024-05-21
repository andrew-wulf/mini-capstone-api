class CreateSuppliers < ActiveRecord::Migration[7.1]
  def change
    create_table :suppliers do |t|
      t.string :name, null: false
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
