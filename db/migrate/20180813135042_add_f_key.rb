class AddFKey < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :service_id, :integer
    #add_reference :contracts, :services
    add_column :contracts, :org_id, :integer
    #add_reference :contracts, :orgs
    add_column :contracts, :contragent_id, :integer
    #add_reference :contracts, :contragents
  end
end
