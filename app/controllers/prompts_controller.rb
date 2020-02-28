class PromptsController < ApplicationController

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

end