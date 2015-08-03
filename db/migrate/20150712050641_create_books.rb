class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :thumbnail_url
      t.string :openlibrary_key
      t.integer :first_publish_year

      t.timestamps null: false
    end
  end
end
