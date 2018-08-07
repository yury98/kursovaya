class Kontragent < ApplicationRecord
  def change
    create_table :kontragents do |t|
      t.string :type
    end
  end
end
