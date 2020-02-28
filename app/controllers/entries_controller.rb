class EntriesController < ApplicationController

  #Create new entry
  post '/entries' do
    @prompt = Prompt.find_by(id: params[:prompt][:id].to_i)
    @journal = @prompt.journal
    if logged_in? && journal_access_valid?
      @prompt.entries.create(params[:entry])
      redirect "/journals/#{@journal.id}/write"
    elsif !logged_in?
      redirect '/login'
    else
      redirect "/user/#{current_user.id}/journals"
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