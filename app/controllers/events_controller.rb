class EventsController < ApplicationController
  def index
    @events = Event.all
    respond_to do |format|
      format.html
   #   format.xml(render :xml => @evetns)
      #format.json(render :xml => @evetns)
    end
  end
  
  def show
    @event = Event.find(params[:id]) rescue nil
      if @event.nil?
      redirect_to user
      else
       respond_to do |format|
          format.html
        #  format.xml { render :xml => @user }
        end
      end
  end
  
  def new
    @event = Event.new
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @event }
    end
  end
  
  def create
    @event = Event.new(params[:event])
    @event.user_id = current_user
    if @event.save
      redirect_to current_user, :notice => 'Event created!'    
    else
      render 'new'
    end
  end

  def edit

   @event = Event.find(params[:id])
   #@current_user_events = Event.find_all_by_user_id(session[:user_id])
   #@current_user_events.each do |event|
   #p event.id
    #  if  event.id != @event.id
   #     p 'test'
    #  end
  # end
  end
  
  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(:back, :notice => 'Event was succesfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @event.errors, :status => :unprocessable_entity }
      end
     end 
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml { head :ok }
    end
  end
end
