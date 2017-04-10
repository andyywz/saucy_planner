class Event < ApplicationRecord
  belongs_to :user
  has_many :attendances, dependent: :destroy
  has_many :people, through: :attendances

  validates_presence_of :name, :date
end
