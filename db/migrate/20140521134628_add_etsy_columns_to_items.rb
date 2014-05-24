class AddEtsyColumnsToItems < ActiveRecord::Migration
  def change
    add_column :items, :etsy_url, :string
    add_column :items, :etsy_id, :string
  end
end
