class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :orgs do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :full_name, null: false
      t.string :small_name, null: false
      t.string :typ, null: false
      t.string :person, null: false
      t.string :usedge, null: false
      t.string :account, null: false
      t.string :u_address, null: false
      t.string :f_address, null: false
      t.binary :foreign, null: false, default: false
      t.integer :square
      t.integer :people
      t.integer :space_fp
      t.binary :status
      t.datetime :last_change
      t.string :last_cb
      t.datetime :created
      t.string :created_by
      t.timestamps
    end
  end
end
