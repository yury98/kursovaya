class AddPartsToKontragents < ActiveRecord::Migration[5.2]
  def change
    change_table :kontragents do |t|
      t.string :name
      t.string :code
      t.string :typ
      t.string :full_name
      t.string :group
      t.string :inn
      t.string :kpp
      t.string :code_okpo
      t.string :tel
      t.string :u_address
      t.string :f_address
      t.string :other
      t.string :bank_code
      t.string :code_name
      t.string :bank_name
      t.binary :status
      t.datetime :last_change
      t.string :last_cb
      t.datetime :created
      t.string :created_by
    end
    change_column_null :kontragents, :name, false
    change_column_null :kontragents, :code, false
    change_column_null :kontragents, :full_name, false
    change_column_null :kontragents, :group, false
    change_column_null :kontragents, :inn, false
    change_column_null :kontragents, :kpp, false
    change_column_null :kontragents, :code_okpo, false
    change_column_null :kontragents, :tel, false
    change_column_null :kontragents, :u_address, false
    change_column_null :kontragents, :f_address, false
  end
end
