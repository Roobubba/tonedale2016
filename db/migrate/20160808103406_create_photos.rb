class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.string :picture
      t.timestamps
    end
  end
end
