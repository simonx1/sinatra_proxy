# config.ru

require 'sinatra'

set :port, 7654
set :run, false
set :environment, ENV['RACK_ENV'] || 'development'

require './application'
run Sinatra::Application
