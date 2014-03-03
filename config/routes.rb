Audio::Application.routes.draw do
  resources :audio_files
  root :to => "audio_files#new"
end
