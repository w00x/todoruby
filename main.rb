require 'rubygems'
require 'bundler/setup'
require 'dotenv/load'
require 'active_record'
current_env = ENV['APP_ENV'] ? ENV['APP_ENV'].to_sym : :development
Bundler.require(:default, current_env)

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/config")
loader.push_dir("#{__dir__}/app")
loader.setup

set port: 8080
include Routes
