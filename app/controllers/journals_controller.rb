class JournalsController < ApplicationController

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
    @journal = @user.journals.find_by(id: params[:id])
    if @journal
      erb :'journals/read'
    else 
      redirect "/user/#{@user.username}"
    end
  end


  get '/journals/:username/:id/write' do 
    @user = find_user_or_logout
    @journal = @user.journals.find_by(id: params[:id])
    if @journal
      erb :'journals/write'
    else 
      redirect "/user/#{@user.username}"
    end
  end

end