ENV['SINATRA_ENV'] ||= 'development'

#load all ruby gems
require 'bundler'
Bundler.require(:default, ENV['SINATRA_ENV'])

#create and connect to database
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

#load all app files NOTE: gem does not respect order, require dependencies first
require_all 'app'
