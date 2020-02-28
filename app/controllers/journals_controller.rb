class JournalsController < ApplicationController

  post '/journals/:username' do
    # @user = find_user_or_logout
    # #create new journal at user
    # @journal = @user.journals.create(params[:journal])
    # #redirect to show page
    # redirect "/journals/#{@user.username}/#{@journal.id}/write"
  end

  get '/journals/:journal_id' do 
    # @user = find_user_or_logout
    # @journal = find_journal_or_redirect
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


  get '/journals/:journal_id/write' do 
    # @user = find_user_or_logout
    # @journal = find_journal_or_redirect
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

  delete '/journals/:username/:journal_id' do
    # # @user = find_user_or_logout
    # # @journal = find_journal_or_redirect
    # @journal.destroy
    # redirect "/user/#{@user.username}"
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