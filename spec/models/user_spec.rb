require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  # ensure User model has a 1:many relationship with the Event model
  it { should have_many(:events) }

  # Validation tests
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:login) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_uniqueness_of(:login).case_insensitive }
end
