class Person < ApplicationRecord
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email, case_sensitive: false
end
