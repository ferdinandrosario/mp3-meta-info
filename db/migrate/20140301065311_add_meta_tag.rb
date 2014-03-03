class AddMetaTag < ActiveRecord::Migration
  def change
  	add_column :audio_files ,:metadata,:text
  end
end