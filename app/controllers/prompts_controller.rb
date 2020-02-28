class PromptsController < ApplicationController

  # post '/prompts/:username/:journal_id' do 
  #   @user = find_user_or_logout
  #   @journal = find_journal_or_redirect
  #   new_prompt = @journal.prompts.create(params[:prompt])
  #   redirect "/journals/#{@user.username}/#{@journal.id}/write"
  # end

  #Create new prompt
  post '/prompts' do
    @journal = Journal.find_by(id: params[:journal][:id].to_i)
    if logged_in? && journal_access_valid?
      @journal.prompts.create(params[:prompt])
    else
      redirect '/login'
    end
    redirect "/journals/#{@journal.id}/write"
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