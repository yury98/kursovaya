class Kontragents < ActiveRecord::Migration[5.2]
  def change
    add_column :kontragents, :number, :integer
    add_column :kontragents, :type, :string
    add_column :kontragents, :full_name, :string
    add_column :kontragents, :group, :string
    add_column :kontragents, :INN, :string
    add_column :kontragents, :KPP, :string
    add_column :kontragents, :kod, :string
    add_column :kontragents, :UAddress, :string
    add_column :kontragents, :FAddress, :string
    add_column :kontragents, :otherInf, :text
  end
end

