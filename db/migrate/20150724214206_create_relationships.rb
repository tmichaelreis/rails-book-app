class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :reader_id
      t.integer :book_id
      t.boolean :has_read

      t.timestamps null: false
    end
    add_index :relationships, :reader_id
    add_index :relationships, :book_id
    add_index :relationships, :has_read
    add_index :relationships, [:reader_id, :book_id], unique: true
  end
end
