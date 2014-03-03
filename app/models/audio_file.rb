class AudioFile < ActiveRecord::Base

  attr_protected
  has_attached_file :audio
  after_create :extract_metadata

  private

  # Retrieves metadata for MP3s
  def extract_metadata
    path = audio.queued_for_write[:original].path
    open_opts = { :encoding => 'utf-8' }
    TagLib::FileRef.open(path) do |fileref|
      tag = fileref.tag
      properties = fileref.audio_properties
      self.update_attributes(:artist => tag.artist,:album=> tag.album,:title => tag.title, :genre => tag.genre, :track_number => tag.track, :year_of_release => tag.year, :comments => tag.comment,:bitrate => properties.bitrate,:no_of_channels => properties.channels,:length=> properties.length,:sample_rate=> properties.sample_rate)
    end
  end
end