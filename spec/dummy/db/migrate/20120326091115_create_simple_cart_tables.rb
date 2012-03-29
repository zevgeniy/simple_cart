class CreateSimpleCartTables < ActiveRecord::Migration
  def up
    create_table :carts do |t|
      t.string  :shopper_type
      t.integer :shopper_id
      t.string  :state

      t.timestamps
    end

    add_index :carts, [:shopper_id, :shopper_type]
    add_index :carts, :state

    create_table :cart_items do |t|
      t.string :cartable_type, :null => false
      t.integer :cartable_id, :null => false
      t.integer :cart_id, :null => false
      t.integer :quantity

      t.timestamps
    end

    add_index :cart_items, [:cartable_id, :cartable_type]
    add_index :cart_items, :cart_id
  end

  def down
    drop_table :carts
    drop_table :cart_items
  end
end