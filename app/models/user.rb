class User < ApplicationRecord
  has_many :events

  validates_presence_of :first_name, :last_name, :email, :login
end
