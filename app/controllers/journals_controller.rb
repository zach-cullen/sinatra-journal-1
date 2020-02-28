class JournalsController < ApplicationController

  #Create new journal
  post '/journals' do
    @user = current_user
    if logged_in? 
      @user.journals.create(params[:journal])
      redirect "/user/#{@user.id}/journals"
    else
      flash[:alert] = "You must be logged in to view this content"
      redirect 'login'
    end
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
  delete '/journals/:journal_id' do
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

end