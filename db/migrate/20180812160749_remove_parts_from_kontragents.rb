class RemovePartsFromKontragents < ActiveRecord::Migration[5.2]
  def change
    remove_column :kontragents, :number, :integer
    remove_column :kontragents, :type, :string
    remove_column :kontragents, :full_name, :string
    remove_column :kontragents, :group, :string
    remove_column :kontragents, :INN, :string
    remove_column :kontragents, :KPP, :string
    remove_column :kontragents, :kod, :string
    remove_column :kontragents, :UAddress, :string
    remove_column :kontragents, :FAddress, :string
    remove_column :kontragents, :otherInf, :text
  end
end
