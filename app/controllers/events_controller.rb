class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def add_participant
    @event = Event.find(params[:id])
    user = User.where("email = ?", params[:email]).first

    if (user.nil?)
      user = User.create(email: params[:email])
    end

    @event.participations.create(user_id: user.id)

    respond_to do |format|
      format.html { redirect_to @event, notice: "Added #{user.email}" } 
    end

  end

  def list_participants
    event = Event.find(params[:id])
    participants = event.participants

    respond_to do |format|
      format.json { render json: participants } 
    end
  end

  def draw_winner
    @event = Event.find(params[:id])

    winner = @event.select_winner_and_save

    respond_to do |format|
      msg =  winner.nil? ? "No one left to draw amongst" : "Congrats to #{winner.email}"
      format.html { redirect_to @event, notice: msg }
    end
  end 

  # GET /events/new
  # GET /events/new.json
  def new
    if flash[:event_params]
      @event = Event.new(flash[:event_params])
      @event.valid?
    else
      @event = Event.new
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end


  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html do
          flash[:error] = "Error creating Event"
          flash[:event_params] = params[:event]
          redirect_to :action => :new 
        end

        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

 
  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
