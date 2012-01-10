class UsersController < ApplicationController
  before_filter :current_required, :except => ["new", "create"]

  def index
    @friends = Friendship.find_by_sql("select * from users where id in 
    (select friendships.id_friend from friendships where friendships.id_user = #{current_user.id})")
            respond_to do |format|
              format.html
            end
  end

  def new
    @user = User.new
  end
  
  def show
      @user = User.find(params[:id]) rescue nil
      @status = Friendship.find_by_id_user_and_id_friend(current_user.id, @user.id)
      $request = Friendship.find_by_id_user_and_request(current_user.id, @user.id)

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
  
  def people
    @people = User.where("not id = #{current_user.id}")
  end 
  
  def invite
    if $request.nil?
        @friend = User.find(params[:id])
        @friendship = Friendship.new(
                                    :id_user => current_user.id,
                                    :id_friend => nil,
                                    :request => @friend.id
                                  )
        if @friendship.save
          redirect_to :back, :notice => 'Request send!'    
        end
    end
  end 
  
  def accept
        @newfriend = User.find(params[:id])
        @friendship = Friendship.new(
                                    :id_user => current_user.id,
                                    :id_friend => @newfriend.id,
                                    :request => nil
                                  )
        if @friendship.save
          redirect_to :back, :notice => @newfriend.fullname+' are now your friend!'    
        end
  end
     
end
