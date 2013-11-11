class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :description
      t.string :file
      t.references :photoable

      t.timestamps
    end
    add_index :photos, :photoable_id
  end
end
