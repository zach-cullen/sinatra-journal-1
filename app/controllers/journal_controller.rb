class JournalsController < ApplicationController

  get '/journals/:username' do
    #list all journals created by user
  end

  post '/journals/:username' do
    binding.pry
    #create new journal at user
  end

end