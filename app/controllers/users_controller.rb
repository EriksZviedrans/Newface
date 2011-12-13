class UsersController < ApplicationController
  
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.xml(render :xml => @users)
      format.json(render :xml => @users)
    end
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => 'Signed Up!'
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
  
  def getjson
 # .parse(open("url_of_json_service").read)
blah = HTTParty.get("https://graph.facebook.com/100002774971272/friends?access_token=AAACEdEose0cBAHoB5SYQZBA9nVZCuApr16V3vo4ebiXZChi78SlLE5yVB7zxkshCBrPkA3b0wllpULuHVhr5H78tTAYIYHiiftbZBCqXmgZDZD")


  puts blah 

  end
     
end
