require 'bundler'
#load all ruby gems
Bundler.require

SINATRA_ENV ||= 'development'

#create and connect to database
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{SINATRA_ENV}.sqlite"
)


#load all app files NOTE: gem does not respect order, require dependencies first
require_all 'app'
