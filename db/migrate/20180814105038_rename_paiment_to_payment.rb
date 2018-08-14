class RenamePaimentToPayment < ActiveRecord::Migration[5.2]
  def change
    rename_table :paiments, :payments
  end
end
