class User < ApplicationRecord
  has_many :events

  validates_presence_of :first_name, :last_name, :email, :login
  validates_uniqueness_of :email, :login, case_sensitive: false
end
