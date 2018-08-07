class CreateKontragents < ActiveRecord::Migration[5.2]
  def change
    create_table :kontragents do |t|
      t.timestamps
    end
  end
end
