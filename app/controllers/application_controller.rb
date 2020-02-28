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

    def current_user
      user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def journal_access_valid?
      if !!@journal && @journal.user == current_user
        true
      else
        false
      end
    end

    def redirect_user_to_self
      redirect "/user/#{current_user.id}/journals"
    end

    def redirect_to_login
      redirect '/login'
    end
  end



end