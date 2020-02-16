class PromptsController < ApplicationController

  post '/prompts/:username/:journal_id' do 
    @user = find_user_or_logout
    @journal = find_journal_or_redirect
  end

end