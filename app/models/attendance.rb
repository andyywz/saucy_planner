class Attendance < ApplicationRecord
  belongs_to :person
  belongs_to :event

  enum status: { not_attending: 0, attending: 1, maybe: 2 }
  validates_presence_of :status
end
