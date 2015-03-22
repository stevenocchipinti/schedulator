class EventsController < ApplicationController
  before_action :event_from_short_hashid, only: [:show, :vote]
  before_action :event_from_long_hashid, only: [:edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    3.times { @event.timeslots.build }
    3.times { @event.attendees.build }
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  # POST /events/1/vote
  # POST /events/1/vote.json
  def vote
    vote_params.each do |timeslot_id, attendee_votes|
      attendee_votes.each do |attendee_id, available|
        Vote.find_or_initialize_by(
          timeslot_id: timeslot_id,
          attendee_id: attendee_id
        ).update(available: available)
      end
    end
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Votes submitted' }
      format.json { render action: 'show', status: :created, location: @event }
    end
  end


  private

  def event_from_short_hashid
    @event = Event.find Event.decode_short_hashid(params[:short_hashid])
  end

  def event_from_long_hashid
    @event = Event.find Event.decode_long_hashid(params[:long_hashid])
  end

  def event_params
    params.require(:event).permit(
      :name,
      :description,
      :timeslots_attributes => [
        :datetime,
        :datetime_string,
        :event_id,
        :id,
        :_destroy
      ],
      :attendees_attributes => [
        :email_address,
        :event_id,
        :id,
        :_destroy
      ]
    )
  end

  def vote_params
    # Not sure how to use StrongParameters with dynamic keys
    params[:votes]
  end

end
