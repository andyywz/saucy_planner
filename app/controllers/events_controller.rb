class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  def index
    @events =
      if params[:user_id]
        User.find(params[:user_id]).events
      else
        Event.all
      end

    json_response(@events)
  end

  def show
    json_response(@event)
  end

  def create
    @event = User.find(params[:user_id]).events.create!(event_params)
    json_response(@event, :created)
  end

  def update
    @event.update(event_params)
    head :no_content
  end

  def destroy
    @event.destroy
    head :no_content
  end

  private

  def event_params
    params.permit(:name, :date, :end_date, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
