class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
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

  
end
