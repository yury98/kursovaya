class AddCon < ActiveRecord::Migration[5.2]
  def change

    change_table :contracts do |t|
      t.binary :gvs
      t.decimal :v_gvs, precision: 10, scale: 2
      t.decimal :t_gvs, precision: 10, scale: 2
      t.decimal :o_gvs, precision: 10, scale: 2
      t.binary :hvs
      t.decimal :v_hvs, precision: 10, scale: 2
      t.decimal :t_hvs, precision: 10, scale: 2
      t.decimal :o_hvs, precision: 10, scale: 2
      t.binary :vgvs
      t.decimal :v_vgvs, precision: 10, scale: 2
      t.decimal :t_vgvs, precision: 10, scale: 2
      t.decimal :o_vgvs, precision: 10, scale: 2
      t.binary :vhvs
      t.decimal :v_vhvs, precision: 10, scale: 2
      t.decimal :t_vhvs, precision: 10, scale: 2
      t.decimal :o_vhvs, precision: 10, scale: 2
      t.binary :otop
      t.decimal :v_otop, precision: 10, scale: 2
      t.decimal :t_otop, precision: 10, scale: 2
      t.decimal :o_otop, precision: 10, scale: 2
      t.binary :exp
      t.decimal :v_exp, precision: 10, scale: 2
      t.decimal :t_exp, precision: 10, scale: 2
      t.decimal :o_exp, precision: 10, scale: 2
      t.binary :tbo
      t.decimal :v_tbo, precision: 10, scale: 2
      t.decimal :t_tbo, precision: 10, scale: 2
      t.decimal :o_tbo, precision: 10, scale: 2
    end
  end
end
