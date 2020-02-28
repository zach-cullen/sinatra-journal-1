class PromptsController < ApplicationController

  #Create new prompt
  post '/prompts' do
    @journal = Journal.find_by(id: params[:journal][:id].to_i)
    if logged_in? && journal_access_valid?
      @journal.prompts.create(params[:prompt])
    elsif !logged_in?
      redirect_to_login
    else
      redirect_user_to_self
    end
  end

end