require 'rails_helper'

RSpec.describe Event, type: :model do
  # Association test
  # ensure an event belongs to a User
  it { should belong_to(:user) }
  # ensure Event model has a 1:many relationship with the Attendance model
  it { should have_many(:attendances) }
  it { should have_many(:people) }

  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:date) }
end
