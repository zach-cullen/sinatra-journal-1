class Prompt < ActiveRecord::Base
  belongs_to :journal
  has_many :entries, :dependent => :destroy
end