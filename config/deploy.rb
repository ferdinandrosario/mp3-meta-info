#############################################################
# RVM bootstrap
#############################################################
# $:.unshift(File.expand_path("~/.rvm/lib"))
# require 'rvm/capistrano'
# $:.unshift("#{ENV["HOME"]}/.rvm/lib")
# require 'rvm'
require 'rvm/capistrano'
#load 'lib/tasks/seed'
# set :rvm_type, :system
# set :rvm_ruby_string, '1.9.3-p286@dev.edgecentre.com'

#############################################################
# Required files
#############################################################
require 'bundler/capistrano'
require 'logger'
require 'rubygems'

require 'net/ssh'
# require 'net/sftp'

#############################################################
# Application
#############################################################
# set :rvm_ruby_string, '1.9.3p286'
# set :rvm_type, :user
set :application, "mp3-meta-info"
set :deploy_to, "/var/www/mp3-meta-info.com"
set :bundle_cmd, "/home/ferdinand/.rvm/gems/ruby-2.1.2@global/bin/bundle"

#############################################################
# Servers
#############################################################

server "192.168.1.150:22" ,:web, :app, :db, :primary => true
set :user, 'ferdinand'
set :password, 'ROSArio123~'
# set :password , Capistrano::CLI.password_prompt("Subversion password: ")
set :domain, 'mp3-meta-info'

#############################################################
# Subversion
#############################################################

# set :scm, :subversion
# set :scm_username, "svn_usrname"
# set :scm_password, 'svn_password  '
set :scm, :git
set :repository, "https://github.com/ferdinandrosario/mp3-meta-info"
set :scm_passphrase, "clarion@123"
set :branch, "master"

# set :svnserver, "http://svn.mysvnserver.com"
# set :server, 'www.mysvnserver.com'
# set :repository,  "http://svn.mysvnserver.com/path/to/repository/"
# set :copy_cache, true

#############################################################
# Settings
#############################################################
set :use_sudo, true
default_run_options[:pty] = true
set :deploy_via, :copy
# set :deploy_via, :checkout
ssh_options[:forward_agent] = true
ssh_options[:port] = 22
ssh_options[:verbose] = Logger::DEBUG
##############################################################
# Optional Server settings
##############################################################
# set :default_shell, "bash -l"
set :rvm_path, "/home/user/.rvm"
set :default_shell, "/bin/bash"
set :default_environment, {
  'BUNDLE_PATH' => '/home/ferdinand/.rvm/gems/ruby-2.1.2@global/bin/',
  'GEM_HOME' => '/home/ferdinand/.rvm/gems/ruby-2.1.2',
  'GEM_PATH' => '/home/ferdinand/.rvm/gems/ruby-2.1.2:/home/ferdinand/.rvm/gems/ruby-2.1.2@global',
  'PATH' => '/home/ferdinand/.rvm/gems/ruby-2.1.2/bin:/home/ferdinand/.rvm/gems/ruby-2.1.2@global/bin:/home/ferdinand/.rvm/gems/ruby-2.1.2/bin:/home/ferdinand/.rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games'
}
set :rails_env, "test"
set :sudopass, "ROSArio123~"
depend :remote, :gem, "bundler", ">=1.1.5"

##############################################################
# Filters
##############################################################
before 'deploy:finalize_update', 'set_current_release'
before 'deploy', 'change_permission_to_777'
after  'deploy:update_code', 'deploy:migrate' #symlink_shared' # uncomment
after  'deploy', 'change_permission_to_775'
after 'deploy:migrate', 'deploy:symlink_shared'
# after 'deploy:migrate', 'deploy:apache_restart' # uncomment

# if you want to clean up old releases on each deploy uncomment this:
# after "bundle:install", "deploy:restart", "deploy:cleanup" # uncomment
# after "deploy", "deploy:bundle_gems"
# after "deploy:bundle_gems", "deploy:restart"
# ssh_options[:keys] = %w(/home/user/.ssh/id_rsa)
# ssh_options[:auth_methods] = %{publickey}

#Net::SSH.start('e-cust.com', 'ubuntu_user', { :verbose => Logger::DEBUG,
#:auth_methods => %w{ publickey } }) do |ssh|
#end

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# role :web, "edge-centre.com"                          # Your HTTP server, Apache/etc
# role :app, "edge-centre.com"                          # This may be the same as your `Web` server
# role :db,  "edge-centre.com", :primary => true        # This is where Rails migrations will run

# namespace :bundle do
# desc "run bundle install and ensure all gem requirements are met"
# task :install do
# run "cd #{current_path} && bundle install --deployment"  if !Dir[current_path] == nil
# end
# end
# before "deploy:restart",

####################################################################
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/branch_request #{release_path}/public/assets/branch_request"
  end

  desc "Precompiling assets"
  puts "********Before Precompile*******************"
  task :precompile do
    puts "********Start Precompile*******************"
    #run "cd #{deploy_to}/current"
    run "cd /var/www/mp3-meta-info.com/current && '/home/ferdinand/.rvm/gems/ruby-2.1.2@global/bin/bundle exec rake assets:precompile RAILS_ENV=production"
    puts "********End Precompile*******************"
    #run "bundle exec rake assets:precompile RAILS_ENV=production" #"cd #{deploy_to}/current && /usr/local/rvm/rubies/ruby-1.9.3-p286/bin/bundle"
  end

  desc "Restarting Apache"
  task :apache_restart do
    run "/etc/init.d/apache2 restart"
  end
end

task :change_permission_to_777 do
  #run "cd /var/www/application_name"
  puts " Start: *** Changing access rights *** "
  run "#{try_sudo} chmod -R 777 /var/www/mp3-meta-info.com"
  puts " END: *** Changing access rights *** "
end

task :change_permission_to_775 do
  #run "cd /var/www/application_name"
  puts " Start: *** Changing access rights back to restricted *** "
  run "#{try_sudo} chmod -R 775 /var/www/mp3-meta-info.com"
  puts " END: *** Changing access rights back to restricted *** "
end

task :set_current_release, :roles => :app do
  set :current_release, latest_release
end