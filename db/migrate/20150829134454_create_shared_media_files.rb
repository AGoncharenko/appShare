class CreateSharedMediaFiles < ActiveRecord::Migration
  def change
    create_table :shared_media_files do |t|
      t.integer :user_id
      t.integer :media_file_id

      t.timestamps null: false
    end
  end
end
