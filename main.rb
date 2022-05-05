require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/config")
loader.push_dir("#{__dir__}/app")
loader.setup

set port: 8080
include Routes
