require 'rails_helper'

RSpec.describe Event, type: :model do
  # Association test
  # ensure an event belongs to a User
  it { should belong_to(:user) }

  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:date) }
end
