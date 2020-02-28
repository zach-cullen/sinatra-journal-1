class JournalsController < ApplicationController

  #Create new journal
  post '/journals' do

  end

  #Read a journal
  get '/journals/:journal_id' do 
    @user = current_user
    @journal = Journal.find_by(id: params[:journal_id])
    if logged_in? && journal_access_valid?
      erb :'journals/read'
    elsif logged_in?
      redirect "user/#{@user.id}/journals"
    else
      flash[:alert] = "You must be logged in to view this content"
      redirect 'login'
    end
  end

  #Write in a journal i.e. make new prompts and entries
  get '/journals/:journal_id/write' do 
    @user = current_user
    @journal = Journal.find_by(id: params[:journal_id])
    if logged_in? && journal_access_valid?
      erb :'journals/write'
    elsif logged_in?
      redirect "user/#{@user.id}/journals"
    else
      flash[:alert] = "You must be logged in to view this content"
      redirect 'login'
    end
  end

  #Render form for updating or deleting a journal
  get '/journals/:journal_id/edit' do 
    @user = current_user
    @journal = Journal.find_by(id: params[:journal_id])
    if logged_in? && journal_access_valid?
      erb :'journals/edit'
    elsif logged_in?
      redirect "user/#{@user.id}/journals"
    else
      flash[:alert] = "You must be logged in to view this content"
      redirect 'login'
    end
  end

  #Update a journal
  patch '/journals/:journal_id' do
    @user = current_user
    @journal = Journal.find_by(id: params[:journal_id])
    if logged_in? && journal_access_valid?
      @journal.update(params[:journal])
    elsif !logged_in?
      flash[:alert] = "You must be logged in to view this content"
      redirect 'login'
    end
    redirect "user/#{@user.id}/journals"
  end

  #Delete a journal
  delete '/journals/:username/:journal_id' do
    @user = current_user
    @journal = Journal.find_by(id: params[:journal_id])
    if logged_in? && journal_access_valid?
      @journal.destroy
    elsif !logged_in?
      flash[:alert] = "You must be logged in to view this content"
      redirect 'login'
    end
    redirect "user/#{@user.id}/journals"
  end

  helpers do 
    # make sure the journal exists and that it belongs to the current user
    def journal_access_valid?
      if !!@journal && @journal.user == current_user
        true
      else
        false
      end
    end
  end
end