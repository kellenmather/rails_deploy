class CreateShoes < ActiveRecord::Migration
  def change
    create_table :shoes do |t|
      t.string :name
      t.date :date
      t.integer :price
      t.references :user, index: true

      t.timestamps
    end
  end
end
