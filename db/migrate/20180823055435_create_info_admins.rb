class CreateInfoAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :info_admins do |t|
      t.string :post
      t.string :address
      t.string :tel
      t.string :destination
      t.string :trans
      t.string :fil
      t.string :bik
      t.string :ksch
      t.string :innkpp
      t.string :gruz
      t.string :addressg

      t.timestamps
    end
  end
end
