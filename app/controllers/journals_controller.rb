class JournalsController < ApplicationController

  post '/journals/:id' do
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

  get '/journals/:journal_id/edit' do 
    # @user = find_user_or_logout
    # @journal = find_journal_or_redirect
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