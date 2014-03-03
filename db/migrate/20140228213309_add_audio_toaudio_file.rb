class AddAudioToaudioFile < ActiveRecord::Migration
  def change
    add_attachment :audio_files, :audio
  end
end
