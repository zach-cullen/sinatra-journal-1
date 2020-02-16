class ApplicationController < Sinatra::Base

  #tell sinatra paths to views, assets, set up cookies
  configure do 
    set :views, "app/views"
    set :public_dir, "public"
    enable :sessions
    set :session_secret, "secure_this_session"
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  helpers do
    def find_user_or_logout
      user = get_user
      if !!user && logged_in?(user)
        user
      else
        redirect '/logout'
      end
    end

    def logged_in?(user)
      !!session[:user_id] && session[:user_id] == user.id
    end

    def get_user
      User.find_by(username: params[:username])
    end
  end

end