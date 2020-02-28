class EntriesController < ApplicationController

  # post '/entries/:username/:journal_id/:prompt_id' do 
  #   @user = find_user_or_logout
  #   @journal = find_journal_or_redirect
  #   @prompt = @journal.prompts.find_by(id: params[:prompt_id])
  #   new_entry = @prompt.entries.create(params[:entry])
  #   redirect "/journals/#{@user.username}/#{@journal.id}/write"
  # end

  # get '/entries/:username/:journal_id/:entry_id/edit' do
  #   @user = find_user_or_logout
  #   @journal = find_journal_or_redirect
  #   @entry = Entry.find_by(id: params[:entry_id])
  #   erb :'journals/edit-entry'
  # end

  # patch '/entries/:username/:journal_id/:entry_id' do
  #   @user = find_user_or_logout
  #   @journal = find_journal_or_redirect
  #   @entry = Entry.find_by(id: params[:entry_id])
  #   @entry.update(params[:entry])
  #   redirect "/journals/#{@user.username}/#{@journal.id}/write"
  # end

  #Create new entry
  post '/entries' do
    @prompt = Prompt.find_by(id: params[:prompt][:id].to_i)
    @journal = @prompt.journal
    if logged_in? && journal_access_valid?
      @prompt.entries.create(params[:entry])
    else
      redirect '/login'
    end
    redirect "/journals/#{@journal.id}/write"
  end

  #render for for Updating entry
  get '/entries/:entry_id/edit' do
    @entry = Entry.find_by(id: params[:entry_id])
    @journal = @entry.prompt.journal
    if logged_in? && journal_access_valid?
      erb :'entries/edit'
    elsif !logged_in?
      flash[:alert] = "You must be logged in to view this content"
      redirect '/login'
    else
      redirect "/user/#{current_user.id}/journals"
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
      redirect '/login'
    else
      redirect "/user/#{current_user.id}/journals"
    end
  end 

  helpers do 

    def journal_access_valid?
      if !!@journal && @journal.user == current_user
        true
      else
        false
      end
    end

  end

end