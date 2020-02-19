class Journal < ActiveRecord::Base
  belongs_to :user
  has_many :prompts, :dependent => :destroy
  has_many :entries, through: :prompts

  def entries_made_today
    #returns array of all entries made in journal today
    today_localtime = Time.now.getlocal.to_date
    entries = self.entries.select{|e| e.date_created_in_localtime == today_localtime}
  end
end