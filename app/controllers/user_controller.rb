class UsersController < ApplicationController

  get '/signup' do 
    #render signup form
    erb :signup
  end

  post '/signup' do
    @user_info = params[:user]
    if !user_info_format_valid?(@user_info)
      #use helper methods to validate formatting and provide user feedback
      redirect '/signup'
    elsif !!User.find_by(username: @user_info[:username]) || !!User.find_by(email: @user_info[:email])
      #redirect to login if username or email not unique
      flash[:alert] = "User already exists with this username or email address."
    else
      #create new user
      User.create(@user_info)
      flash[:alert] = "Success! Please log in to continue."
    end

    #send to login 
    redirect '/login'
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    #find user if email is in database
    user = User.find_by(email: params[:user][:email])

    #if found user and password matches create session user and redirect to account
    if user && user.authenticate(params[:user][:password])
      #start session and redirect to user account
      session[:user_id] = user.id
      redirect "/user/#{user.username}"
    elsif !user
      #if user is not found, ask to sign up
      flash[:alert] = 'No user found with that email address, please <a href="/signup">sign up</a> or try again.'
      redirect '/login'
    else
      #if user found but password incorrect, ask to try again
      flash[:alert] = "Incorrect password, please try again."
      redirect '/login'
    end
  end

  
  get '/user/:username' do
    account = User.find_by(username: params[:username])
    @user = User.find(session[:user_id])
    
    if @user && @user == account
      erb :account
    elsif !account
      flash.now[:alert] = "Error Page Does Not Exit"
    else
      flash.now[:alert] = "Not logged in!"
      redirect '/login'
    end
  end

  get '/logout' do
    #clear session
    #send to home page
  end

  get '/failure' do
    #send to login w/ message
  end 

  get '/delete' do
    #delete user
  end

  helpers do 
    def username_format_valid?(string)
      valid_format = true
      if string.length < 6
        valid_format = false
        flash[:alert] = "username must be at least 6 characters"
      elsif /\A[a-zA-Z0-9-]*\z/.match(string).to_s != string
        valid_format = false
        flash[:alert] = "username may only contain letters, numbers, and hyphens"
      end
      valid_format
    end
    
    def email_format_valid?(string)
      valid_format = true
      if string == "" || /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/.match(string).to_s != string
        valid_format = false
        flash[:alert] = "please enter a valid email address"
      end
      valid_format
    end

    def password_format_valid?(string)
      valid_format = true
      if string.length < 7
        valid_format = false
        flash[:alert] = "password must be at least 7 characters"
      elsif string.include?(" ")
        valid_format = false
        flash[:alert] = "password may not contain spaces"
      end
      valid_format
    end

    def user_info_format_valid?(user_info)
      valid_format = true
      if !username_format_valid?(user_info[:username]) || !email_format_valid?(user_info[:email]) || !password_format_valid?(user_info[:password])
        valid_format = false
      end 
      valid_format
    end
  end

end