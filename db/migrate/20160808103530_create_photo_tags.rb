class CreatePhotoTags < ActiveRecord::Migration
  def change
    create_table :photo_tags do |t|
      t.integer :photo_id, :tag_id
    end
  end
end
