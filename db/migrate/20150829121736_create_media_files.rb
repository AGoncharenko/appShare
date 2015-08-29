class CreateMediaFiles < ActiveRecord::Migration
  def change
    create_table :media_files do |t|
      t.integer :user_id
      t.string :uploaded_file

      t.timestamps null: false
    end
  end
end
