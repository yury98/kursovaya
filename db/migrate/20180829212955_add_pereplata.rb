class AddPereplata < ActiveRecord::Migration[5.2]
  def change
    change_table :payments do |t|
      t.decimal :perep, precision: 10, scale: 2, default: 0
    end
  end
end
