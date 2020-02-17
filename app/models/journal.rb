class Journal < ActiveRecord::Base
  belongs_to :user
  has_many :prompts
  has_many :entries, through: :prompts
end