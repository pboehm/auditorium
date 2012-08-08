default_run_options[:shell] = '/bin/bash'

set :application, "auditorium"
set :repository,  "https://github.com/pboehm/auditorium.git"

set :scm, :git
set :port, 2222
set :user, "apache"
set :use_sudo, false

set :deploy_to, "/usr/local/rails/#{application}"

server "i77i.de", :app, :web, :db, :primary => true

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :bundle, :roles => :app  do
    run "cd #{current_path} && source /etc/profile.d/rvm.sh && bundle"
  end

  task :assets_precompile, :roles => :app do
    run "cd #{current_path} && source /etc/profile.d/rvm.sh && rake assets:precompile"
  end
end

after "deploy:update", "deploy:bundle"
after "deploy:bundle", "deploy:assets_precompile"



