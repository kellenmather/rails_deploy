class AddAnotherCatToShoe < ActiveRecord::Migration
  def change
    add_column :shoes, :seller_id, :integer
  end
end
