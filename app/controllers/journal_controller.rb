class JournalsController < ApplicationController

  get '/journals/:username' do
    @user = find_user_or_logout
    #list all journals created by user
  end

  post '/journals/:username' do
    @user = find_user_or_logout
    binding.pry
    #create new journal at user
    @journal = @user.journals.create(params[:journal])
    #redirect to show page
    binding.pry
    redirect "/journals/#{@user.username}/#{@journal.id}"
  end

  get '/journals/:username/:id' do 
    @user = find_user_or_logout
    @journal = Journal.find(params[:id])
    erb :show
  end

end