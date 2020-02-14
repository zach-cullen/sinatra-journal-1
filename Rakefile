ENV["SINATRA_ENV"] ||= "development"
require_relative './config/environment'

#load the sinatra activerecord rake task library i.e. migrations
require 'sinatra/activerecord/rake'

desc 'Start a pry session'
task :console do 
  Pry.start
end