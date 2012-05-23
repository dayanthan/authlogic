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


def forgot_password
  if current_user
    redirect_to(:controller =>"user_sessions", :action =>"new")
  else
    @user_session = UserSession.new()
  end
end

def forgot_password_lookup_email
  if current_user
    redirect_to new_url
  else
    user = User.find_by_email(params[:user_session][:email])
    if user
      user.send_forgot_password!
      flash[:notice] = "A link to reset your password has been mailed to you. pls check your Email."
      redirect_to root_url
    else
      flash[:notice] = "Email #{params[:user_session][:email]} wasn't found.  Perhaps you used a different one?  Or never registered or something?"
      render :action => :forgot_password
    end
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

        
