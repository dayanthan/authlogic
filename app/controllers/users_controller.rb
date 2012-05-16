class UsersController < ApplicationController
#before_filter :authenticate, :only => [:index,:changepassword,:edit, :update, :destroy]
before_filter :authenticate, :only => [:index, :edit, :update, :destroy] 
  def new
   @user = User.new
  end

def create
  @user = User.new(params[:user])
  # Saving without session maintenance to skip
  # auto-login which can't happen here because
  # the User has not yet been activated
  if @user.save_without_session_maintenance
    @user.send_activation_instructions!      # new method in the User model
    flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
    redirect_to root_url
  else
    flash[:notice] = "There was a problem creating the user"
    render :action => :new
  end
end

def activate
  @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
  
  raise Exception if @user.active?
  
  if @user.activate!
    flash[:notice] = "Your Account has been activated."
    UserSession.create(@user, false)
    @user.send_activation_confirmation!
    redirect_to(:controller =>"user_sessions", :action =>"new")
  else
    flash[:alert] = "Sorry your account has been problem!"
    render :action => :new
  end
end

  # def create
  #  @user = User.new(params[:user])
  #  @user.user_type = "1"
  #   #if @user.save
  #   if @user.save_without_session_maintenance
  #    flash[:notice] = "Check your Email and activate ur account."
  #     @email = params[:user][:email]
  #     @from_email ="surya@vervesys.com"
  #     @msg = @user.perishable_token
  #     @subject ="New Registration"
  #     UserMailer.welcome_message(@email,@from_email,@subject,@msg).deliver
  #       render :action => :new
  #   else
  #    flash[:alert] = "Sorry your account has been problem!"
  #    redirect_to(:controller =>"users", :action =>"new")
  #   end      
  # end
 
 
   
  def forgot_password
    render :partial =>"/home/forgotpwd"
  end
def updatepassWithEmail
  	 @email=params[:email]
  	 @user=User.find_by_email(@email)
         @from_email = "surya@vervesys.com"
         
  	 if !@user.nil?             
         @subject='Forgot Password'
  	     @user.create_reset_code
  	     @msg = @user.reset_code

             UserMailer.registration_confirmation(@email,@from_email,@subject,@msg).deliver
             @message = "Your password reset successfully,Please check email for a new password."
        else 
          flash[:alert]="Email adrress not present"
        end
  
  	render :update do |page|
  	    page.replace_html  "forgot_div" ,:partial=>"users/updatepassWithEmail",:locals=>{:message=>@message}
  	end
	
  end
   def newpass

      	begin
      		@user = User.find_by_reset_code(params[:reset_code])
      		if @user.nil? && @user.blank?
      			flash[:notice] = "You are not authorised user"
      			redirect_to "/"
      		else
      			flash[:notice] = "Your Request of reset password approved"
      			session[:user_id] = @user.user_id
        		current_user = @user
    		  
      			session[:reset_pass] = true
      			redirect_to "/user/changepwd/?id=#{@user.user_id}"
      		end
  	     rescue => e
  		    redirect_to "/"
  	     end
    end
     def reset_pass
       @user = User.find_by_user_id(params[:id])
        if ( !params[:password_confirmation].blank?)
            @user.password_confirmation = params[:password_confirmation]
            @user.password = params[:password]
  
            if @user.save!
                flash[:notice] = "Password successfully updated"
                redirect_to login_path
            else
                flash[:alert] = "Password not changed"
               # render :action => 'changepwd'
            end
         else
            flash[:alert] = "New Password mismatch"
            #render :action => 'changepwd'
        end
   end
    def changepwd
     @user_id = params[:id]
      if params[:from] == "edit"
         session[:reset_pass]= false
      end
      @user = User.find_by_user_id(params[:id])
  end

  def updatechangepwd

       @user = current_user
      if @user.valid_password?(params[:old_password])

    
            if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
                current_user.password_confirmation = params[:password_confirmation]
                current_user.password = params[:password]

                if current_user.save!
                    flash[:notice] = "Password successfully updated"
                    redirect_to index_path
                else
                    flash[:alert] = "Password not changed"
                    redirect_to :controller=>"users", :action => 'changepwd',:from=>"edit"
                end

            else
                flash[:alert] = "New Password mismatch"
                 redirect_to :controller=>"users", :action => 'changepwd',:from=>"edit"
            end
        else
            flash[:alert] = "Old password incorrect"
            redirect_to :controller=>"users", :action => 'changepwd',:from=>"edit"
        end

  end

def change_password

	@user = current_user
        if @user.valid_password?(params[:old_password])
	#if User.authenticate(current_user, params[:old_password])
            if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
                current_user.password_confirmation = params[:password_confirmation]
                current_user.password = params[:password]
                
                if current_user.save!
                    flash[:notice] = "Password successfully updated"
                    redirect_to(:controller =>"user_sessions", :action =>"new")
                else
                    flash[:alert] = "Password not changed"
                    render :action => 'change_password'
                end
                 
            else
                flash[:alert] = "New Password mismatch" 
                render :action => 'change_password'
            end
        else
            flash[:alert] = "Old password incorrect" 
            render :action => 'change_password'
        end
    end


   
end

