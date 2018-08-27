class AddInfoForContracts < ActiveRecord::Migration[5.2]
  def change
    change_table :contracts do |t|
      t.string :nds
      t.string :kod_p
      t.string :innkpp
      t.string :rsch
      t.string :bank
      t.string :ksch
      t.string :bik
      t.string :u_address
      t.string :tel
      t.string :p_address
      t.string :price_name
      t.decimal :price_nds, precision: 10, scale: 2
    end

    change_table :info_admins do |t|
      t.string :dir
      t.string :main_buh
    end

    change_table :payments do |t|
      t.string :file_name
    end
  end
end
