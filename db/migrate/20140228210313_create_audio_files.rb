class CreateAudioFiles < ActiveRecord::Migration
  def change
    create_table :audio_files do |t|
      t.string :artist
      t.string :album
      t.string :title
      t.string :genre
      t.integer :track_number
      t.integer :year_of_release
      t.string :comments
      t.string :bitrate
      t.integer :no_of_channels
      t.integer :length
      t.integer :sample_rate
      t.timestamps
    end
  end
end
