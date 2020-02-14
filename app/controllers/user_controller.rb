class UsersController < ApplicationController

  get '/signup' do 
    #render signup form
    erb :signup
  end

  post '/signup' do
    @user_info = params[:user]
    #user entered a properly formatted username
    if !username_format_valid?(@user_info[:username])
      redirect '/signup'
    elsif !password_format_valid?(@user_info[:password])
      redirect '/signup'
    else
      flash.now[:notice] = "looks good"
    end


    #user entered a properly formatted password

    #user entered valid email
    #user entered password
    #username is unique
    #email is unique
    #create new user
    #send to login
  end

  get '/login' do
    #user email is in database
    #user password matches 
    #create session user_id
    #send to user/:slug
  end

  get '/user/:slug' do
    #load user home page
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
        flash.now = "username may only contain letters, numbers, and hyphens"
      end
      valid_format
    end
    
    def email_format_valid?(string)

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


  end

end