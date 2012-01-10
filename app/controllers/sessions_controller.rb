class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to current_user
    end
  end
  
  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      user.online = true
      user.save
      redirect_to users_path, :notice => 'Logged in!'
    else
      flash.now.alert = 'Invalid login or password'
      render 'new'
    end
  end
  
  def destroy
    current_user.online = false
    current_user.save
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Logged out!'   
  end
  
end

