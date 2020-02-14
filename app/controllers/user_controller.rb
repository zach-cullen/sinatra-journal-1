class UsersController < Sinatra::Base


  get '/signup' do 
    #create new user
    #user entered username w/ only acceptable characters
    #user entered email
    #user entered password
    #username is unique
    #email is unique
    #send to login
  end

  get '/login' do
    #user email is in database
    #user password matches 
    #create session user_id
    #send to user/:slug
  end

  get '/user/:slug' do

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

end