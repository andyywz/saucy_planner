require 'rails_helper'

RSpec.describe Person, type: :model do
  # Association test
  # ensure Person model has a 1:many relationship with the Attendance model
  it { should have_many(:attendances) }
  it { should have_many(:events) }

  # Validation tests
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
end
