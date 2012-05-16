class ApplicationController < ActionController::Base
 # protect_from_forgery
helper_method :current_user_session, :current_user
  protect_from_forgery
  helper_method :current_user  
   before_filter :new_user_session
 
   def new_user_session
      @user_session = UserSession.new
   end


    private  
    def current_user_session  
      return @current_user_session if defined?(@current_user_session)  
      @current_user_session = UserSession.find  
    end  
     
    def current_user  
     @current_user = current_user_session && current_user_session.record  
   end 
end
