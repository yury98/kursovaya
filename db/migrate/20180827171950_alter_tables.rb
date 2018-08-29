class AlterTables < ActiveRecord::Migration[5.2]
  def change
    change_table :payments do |t|
      t.string :nazn
      t.boolean :paid
    end
  end
end
