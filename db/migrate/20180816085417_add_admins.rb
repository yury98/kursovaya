class AddAdmins < ActiveRecord::Migration[5.2]
  def change
    remove_column :orgs, :last_cb, :date
    remove_column :orgs, :last_change, :date
    remove_column :orgs, :created, :date
    remove_column :contragents, :last_change, :date
    remove_column :contragents, :last_cb, :date
    remove_column :contragents, :created, :date
    add_column :contracts, :last_cb, :string
    add_column :contracts, :created_by, :string
    add_column :payments, :last_cb, :string
    add_column :payments, :created_by, :string
    add_column :contragents, :last_cb, :string
    add_column :orgs, :last_cb, :string
  end
end
