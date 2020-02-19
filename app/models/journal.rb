class Journal < ActiveRecord::Base
  belongs_to :user
  has_many :prompts, :dependent => :destroy
  has_many :entries, through: :prompts

  def entries_made_today_in_localtime
    #returns number of entries made in journal today or nil
    today_localtime = Time.now.getlocal.to_date
    entries = self.entries.select{|e| e.date_created_in_localtime == today_localtime}
    entries ? entries.count : nil
  end
end