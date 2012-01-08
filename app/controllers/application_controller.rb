class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :current_user_events, :status
  
  private  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def current_required
	  current_user ? true : access_denied
	end
	
	def access_denied
      respond_to do |format|
        format.html do
          session[:return_to] = request.url
          redirect_to(root_url)
        end
        format.any(:json, :xml) do
        end
      end
  end
  
  def current_user_events
      @current_user_events ||= Event.find_all_by_user_id(session[:user_id])
      @current_user_events.each do |events|
     
        if events.user_id == current_user.id
          @events
        end
      end
  end
  
  def status
    @user = User.find(params[:id]) 
    @friend = Friendship.find_by_id_user_and_id_friend(current_user.id, @user.id)
  end 

  
end
