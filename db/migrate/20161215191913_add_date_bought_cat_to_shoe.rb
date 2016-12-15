class AddDateBoughtCatToShoe < ActiveRecord::Migration
  def change
    add_column :shoes, :date_bought_sold, :date
  end
end
