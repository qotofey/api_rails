require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/scm/git'

install_plugin Capistrano::SCM::Git

require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'
require 'capistrano/puma'

install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Systemd

set :rbenv_type, :user
set :rbenv_ruby, '2.7.4'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
