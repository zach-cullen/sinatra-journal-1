class Entry < ActiveRecord::Base
  belongs_to :prompt

  def date_created_in_localtime
    time = (self.created_at + Time.now.getlocal.gmt_offset).to_date
  end
end