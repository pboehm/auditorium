class EventsController < ApplicationController

  def index
    @events = Event.in_future

    @title = "Ausstehende Termine"
  end

  def new
    @event = Event.new
    @title = "Neuen Termin erstellen"
  end

  def edit
    @event = Event.find(params[:id])

    unless current_user == @event.user
      redirect_to event_path(@post),
        notice: 'Du kannst nur eigene Termine bearbeiten !!!'
    end

    if @event
      @title = "Diskussion #%d bearbeiten" % @event.id
    end
  end

  def create
    @event = Event.new(params[:event])
    @event.user = current_user

    if @event.save
      redirect_to root_path, notice: 'Termin erfolgreich erstellt.'
    else
      render action: "new"
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to root_path, notice: 'Termin erfolgreich aktualisiert.'
    else
      render action: "edit"
    end
  end
end
