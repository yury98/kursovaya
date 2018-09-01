class AddToPayments < ActiveRecord::Migration[5.2]
  def change
    change_table :payments do |t|
      t.decimal :price, precision: 10, scale: 2
      t.decimal :v_gvs, precision: 10, scale: 2
      t.decimal :t_gvs, precision: 10, scale: 2
      t.decimal :o_gvs, precision: 10, scale: 2
      t.decimal :v_hvs, precision: 10, scale: 2
      t.decimal :t_hvs, precision: 10, scale: 2
      t.decimal :o_hvs, precision: 10, scale: 2
      t.decimal :v_vgvs, precision: 10, scale: 2
      t.decimal :t_vgvs, precision: 10, scale: 2
      t.decimal :o_vgvs, precision: 10, scale: 2
      t.decimal :v_vhvs, precision: 10, scale: 2
      t.decimal :t_vhvs, precision: 10, scale: 2
      t.decimal :o_vhvs, precision: 10, scale: 2
      t.decimal :v_otop, precision: 10, scale: 2
      t.decimal :t_otop, precision: 10, scale: 2
      t.decimal :o_otop, precision: 10, scale: 2
      t.decimal :v_exp, precision: 10, scale: 2
      t.decimal :t_exp, precision: 10, scale: 2
      t.decimal :o_exp, precision: 10, scale: 2
      t.decimal :v_tbo, precision: 10, scale: 2
      t.decimal :t_tbo, precision: 10, scale: 2
      t.decimal :o_tbo, precision: 10, scale: 2
      t.string :price_name
      t.decimal :price_nds, precision: 10, scale: 2
    end
  end
end
