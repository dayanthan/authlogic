class UserSessionsController < ApplicationController
	  def new
	    @user_session = UserSession.new
	  end
		 
 	 def create
	  	 #@user_session = UserSession.new(params[:user_session])
		 session[:user_email] = params[:user_session][:username]
	 	 @user_session = UserSession.new(params[:user_session])
        	 @user = User.find_by_email(params[:user_session][:username])
	    
	    if @user_session.save
	        flash[:notice] = "Login successful!"
	        redirect_to(:controller =>"users", :action =>"change_password")
	    else
		#render :action=>"new"
	 	redirect_to(:controller =>"user_sessions", :action =>"new")
	        flash[:alert] = "Sorry your Email&password incorrect!"
	    end
	 end

	
    def destroy  
      @user_session = UserSession.find  
      @user_session.destroy  
      flash[:notice] = "Successfully logged out."  
      redirect_to(:controller =>"users", :action =>"new")
      #redirect_to root_url  
   end  


  	#def destroy
	 #   current_user_session.destroy
	  #  flash[:notice] = "Logout successful!"
   	    #redirect_to(:controller =>"users", :action =>"new")
	#end
	
end

        
