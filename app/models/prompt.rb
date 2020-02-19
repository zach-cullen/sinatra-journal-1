class Prompt < ActiveRecord::Base
  belongs_to :journal
  has_many :entries, :dependent => :destroy

  def entry_made_today
    #returns true or false if an entry was already made today for this prompt
    self.journal.entries_made_today.find{|e| e.prompt == self}
  end
end