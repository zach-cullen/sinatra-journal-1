class User < ActiveRecord::Base
  has_secure_password
  has_many :journals
  has_many :prompts, through: :journals
  has_many :entries, through: :prompts
end