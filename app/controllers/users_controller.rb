class UsersController < ApplicationController
  
  def index
    @users = User.all
    respond_to do |format|
      format.html
 #     format.xml(render :xml => @users)
  #    format.json(render :xml => @users)
    end
  end

  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id]) rescue nil
      if @user.nil?
      redirect_to root_url
      else
       respond_to do |format|
          format.html
        #  format.xml { render :xml => @user }
        end
      end
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to log_in, :notice => 'Signed Up!' 
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(:back, :notice => 'User was succesfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
     end 
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml { head :ok }
    end
  end
  
  def code_image 
    @user = User.find(params[:id])
    @image = @user.binary_data
    send_data @image, :type => @user.content_type, :filename => @user.file_name, :disposition => 'inline'
  end
#  def getjson
 #     logger.debug "Person attributes has"
#logger.info "Processing the request..."
#logger.fatal "Terminating application, raised unrecoverable error!!!"
#  end
     
end
