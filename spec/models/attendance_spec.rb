require 'rails_helper'

RSpec.describe Attendance, type: :model do
  # Association test
  # ensure an attendance belongs to a Person and an Event
  it { should belong_to(:person) }
  it { should belong_to(:event) }

  # Validation tests
  it { should validate_presence_of(:status) }
  it { should define_enum_for(:status) }
end
