class EntriesController < ApplicationController

  post '/entries/:username/:journal_id/:prompt_id' do 
    @user = find_user_or_logout
    @journal = find_journal_or_redirect
    @prompt = @journal.prompts.find_by(id: params[:prompt_id])
    new_entry = @prompt.entries.create(params[:entry])
    redirect "/journals/#{@user.username}/#{@journal.id}/write"
  end

end