source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '3.2.17'
gem 'capistrano', '2.14.2'
gem 'rvm-capistrano'
gem 'net-ssh', '2.7.0'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'jquery-rails'
gem 'figaro'
gem 'pg'
gem 'taglib-ruby','0.6.0'
gem "paperclip",'3.5.4'
gem 'aws-sdk'
gem 'ruby-mp3info', :require => 'mp3info'
gem 'therubyracer', :platform=>:ruby
group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'rails_layout'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails','2.14.2'
end
group :test do
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'shoulda-matchers'
end
