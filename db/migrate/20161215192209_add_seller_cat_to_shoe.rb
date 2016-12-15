class AddSellerCatToShoe < ActiveRecord::Migration
  def change
    add_column :shoes, :seller_name, :string
  end
end
