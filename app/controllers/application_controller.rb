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

  #   def find_user_or_logout
  #     #finds a user via route parameters unless they are not logged in
  #     user = get_user
  #     if !!user && logged_in?(user)
  #       user
  #     else
  #       redirect '/logout'
  #     end
  #   end

  #   def find_journal_or_redirect
  #     #finds a journal via route parameters unless it doesn't belong to the logged in user
  #     journal = @user.journals.find_by(id: params[:journal_id])
  #     redirect "/user/#{@user.username}" if !journal
  #     journal
  #   end

  #   def logged_in?(user)
  #     !!session[:user_id] && session[:user_id] == user.id
  #   end

  #   def get_user
  #     User.find_by(username: params[:username])
  #   end
  end



end