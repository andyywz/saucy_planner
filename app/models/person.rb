class Person < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email

  validates_uniqueness_of :email, case_sensitive: false
end
