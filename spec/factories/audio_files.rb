# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :audio_file do
    artist "MyString"
    album "MyString"
    title "MyString"
    genre "MyString"
    track_number 1
    year_of_release 1
    comments "MyString"
    bitrate "MyString"
    no_of_channels 1
    length 1
    sample_rate 1
  end
end
