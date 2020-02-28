class EntriesController < ApplicationController

  #Create new entry
  post '/entries' do
    @prompt = Prompt.find_by(id: params[:prompt][:id].to_i)
    @journal = @prompt.journal
    if logged_in? && journal_access_valid?
      @prompt.entries.create(params[:entry])
      redirect "/journals/#{@journal.id}/write"
    elsif !logged_in?
      redirect_to_login
    else
      redirect_user_to_self
    end
  end

  #render for for Updating entry
  get '/entries/:entry_id/edit' do
    @entry = Entry.find_by(id: params[:entry_id])
    @journal = @entry.prompt.journal
    if logged_in? && journal_access_valid?
      erb :'entries/edit'
    elsif !logged_in?
      flash[:alert] = "You must be logged in to view this content"
      redirect_to_login
    else
      redirect_user_to_self
    end
  end

  #Update entry
  patch '/entries/:entry_id' do
    @entry = Entry.find_by(id: params[:entry_id])
    @journal = @entry.prompt.journal
    if logged_in? && journal_access_valid?
      @entry.update(params[:entry])
      redirect "/journals/#{@journal.id}/write"
    elsif !logged_in? 
      redirect_to_login
    else
      redirect_user_to_self
    end
  end 

  #Delete entry
  delete '/entries/:entry_id' do
    @entry = Entry.find_by(id: params[:entry_id])
    @journal = @entry.prompt.journal
    if logged_in? && journal_access_valid?
      @entry.destroy
      redirect "/journals/#{@journal.id}/write"
    elsif !logged_in?
      redirect_to_login
    else
      redirect_user_to_self
    end
  end

end