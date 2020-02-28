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

  end

  #Update entry
  patch '/entries/:entry_id' do

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