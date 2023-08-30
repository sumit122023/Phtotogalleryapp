class AddPublishedToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :published, :boolean
    add_reference :albums, :user,  foreign_key: true
  end
end
