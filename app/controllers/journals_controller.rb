class JournalsController < ApplicationController

  post '/journals/:username' do
    @user = find_user_or_logout
    #create new journal at user
    @journal = @user.journals.create(params[:journal])
    #redirect to show page
    redirect "/journals/#{@user.username}/#{@journal.id}/write"
  end

  get '/journals/:username/:journal_id' do 
    @user = find_user_or_logout
    @journal = find_journal_or_redirect
    erb :'journals/read'
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