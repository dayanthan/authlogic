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
 
# def forgot_password

#     @user = User.find_by_email(params[:email])
#     if user
#       @user.send_forgot_password!
#       flash[:notice] = "A link to reset your password has been mailed to you."
#     else
#       flash[:notice] = "Email #{params[:user_session][:email]} wasn't found.  Perhaps you used a different one?  Or never registered or something?"
#       render :action => :forgot_password
#     end
#   end 

def reset_password
  @user = User.find_using_perishable_token(params[:reset_password_code], 1.week) || (raise Exception)
end

def reset_password_submit
  @user = User.find_using_perishable_token(params[:reset_password_code], 1.week) || (raise Exception)
  @user.active = true
  if @user.update_attributes(params[:user].merge({:active => true}))
    flash[:notice] = "Successfully reset password."
    redirect_to(:controller =>"user_sessions", :action =>"new")
  else
    flash[:notice] = "There was a problem resetting your password."
    render :action => :reset_password
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

