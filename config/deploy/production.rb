# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}
server '45.141.79.240', roles: %w[web app db], primary: true

set :stage, :production
set :rails_env, :production
set :branch, 'main'

set :user, 'deploy'
set :use_sudo, false
set :deploy_via, :remote_cache
set :rbenv_custom_path, '/home/deploy/.rbenv'

#For puma
set :puma_threads, [4, 16]
set :puma_workers, 1
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

set :puma_user, fetch(:user)
set :puma_systemctl_user, fetch(:user)
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_restart_command, 'bundle exec puma'

# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir /var/www/vhosts/api-rails/shared/tmp/sockets -p"
#       execute "mkdir /var/www/vhosts/api-rails/shared/tmp/pids -p"
#     end
#   end
#
#   before 'deploy:starting', 'puma:make_dirs'
# end

# namespace :deploy do
#   desc "Make sure local git is in sync with remote."
#   task :check_revision do
#     on roles(:app) do
#
#       # Update this to your branch name: master, main, etc. Here it's main
#       unless `git rev-parse HEAD` == `git rev-parse origin/main`
#         puts "WARNING: HEAD is not the same as origin/main"
#         puts "Run `git push` to sync changes."
#         exit
#       end
#     end
#   end

  # desc 'Initial Deploy'
  # task :initial do
  #   on roles(:app) do
  #     before 'deploy:restart', 'puma:start'
  #     invoke 'deploy'
  #   end
  # end
  #
  # desc 'Restart application'
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     invoke 'puma:restart'
  #   end
  # end

#   before :starting, :check_revision
#   after :finishing, :cleanup
# end

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
 set :ssh_options, {
   keys: %w(~/.ssh/id_rsa.pub),
   forward_agent: true,
   user: fetch(:user)
 }

# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
