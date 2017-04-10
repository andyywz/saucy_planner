class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :update, :destroy]

  def index
    @people =
      if params[:event_id]
        # Find all people that have responded to the event
        Event.find(params[:event_id]).people
      else
        Person.all
      end

    json_response(@people)
  end

  def show
    json_response(@person)
  end

  def create
    existing_person = Person.find_by_email(params[:email])
    @person = existing_person.present? ? existing_person : Person.create!(person_params)

    if params[:event_id]
      # Create an attendance record for event and person
      Attendance.create!(attendance_params.merge(person_id: @person.id))
    end

    json_response(@person, :created)
  end

  def update
    @person.update(person_params)
    head :no_content
  end

  def destroy
    @person.destroy
    head :no_content
  end

  private

  def person_params
    params.permit(:first_name, :last_name, :email)
  end

  def attendance_params
    params.permit(:event_id, :status)
  end

  def set_person
    @person = Person.find(params[:id])
  end
end
