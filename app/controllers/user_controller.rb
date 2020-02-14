class UsersController < ApplicationController

  get '/signup' do 
    #render signup form
    erb :signup

  end

  post '/signup' do
    binding.pry
    #user entered username w/ only acceptable characters
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

end