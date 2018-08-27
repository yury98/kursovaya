class CreateContragents < ActiveRecord::Migration[5.2]
  def change
    #drop_table :kontragents

    create_table :contragents do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :typ, null: false
      t.string :full_name, null: false
      t.string :group, null: false
      t.string :inn, null: false
      t.string :kpp, null: false
      t.string :code_okpo, null: false
      t.string :tel, null: false
      t.string :u_address, null: false
      t.string :f_address, null: false
      t.string :other
      t.string :bank_code, null: false
      t.string :code_name, null: false
      t.string :bank_name, null: false
      t.binary :status
      t.datetime :last_change
      t.string :last_cb
      t.datetime :created
      t.string :created_by
      t.timestamps
    end
  end
end
