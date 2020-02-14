class ApplicationController < Sinatra::Base

  #tell sinatra paths to views, assets, set up cookies
  configure do 
    set :views, "app/views"
    set :public_dir, "public"
    enable :sessions
    set :session_secret, "secure_this_session"
  end

  get '/' do
    erb :index
  end

end