class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.string :name, null: false
      t.string :code
      t.decimal :price, precision: 10, scale: 2
      t.date :podp_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end
