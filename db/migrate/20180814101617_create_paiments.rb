class CreatePaiments < ActiveRecord::Migration[5.2]
  def change
    create_table :paiments do |t|
      t.integer :contract_id
      t.integer :number
      t.date :date
      t.date :month
      t.string :bank
      t.decimal :summ, precision: 10, scale: 2

      t.timestamps
    end
  end
end
