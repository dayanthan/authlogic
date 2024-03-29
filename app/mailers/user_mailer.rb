class UserMailer < ActionMailer::Base

   default :from => "surya@vervesys.com"

   def activation_instructions(user)
       from "surya@vervesys.com"
       @msg = user.perishable_token
       mail(:to => user.email, :msg => user.perishable_token, :subject => "New Registration", :from => from) 
     
   end
  
   def activation_confirmation(user)
           from "surya@vervesys.com" 
           mail(:to => user.email, :subject => "Activation Complete", :from => from) 
   end

   def contactus(name,email,from_mail,subject,msg)
       @msg = msg
       @name=name
       mail(:to => email, :subject => subject, :from => from_mail) 
   end
  
   def registration_confirmation(email,from_mail,subject,msg)
      @msg = msg
      mail(:to => email, :subject => subject, :from => from_mail) 
   end 

   def forgot_password(user)
      from "surya@vervesys.com" 
      @msg = user.perishable_token
      mail(:to => user.email, :msg => user.perishable_token, :subject => "Password Reset", :from => from) 
   end

# :reset_password_link => user.reset_password_url,
#def forgot_password(user)
#  from          "Binary Logic Notifier <noreply@binarylogic.com>"
#  @reset_password_link = reset_password_url(user.perishable_token) 
#  mail(:to => user.email_address_with_name,
#       :subject => "Password Reset",
#       :from => from,
#       :fail_to => from
#  ) do |format|
#    format.text
#  end
#end

# def activation_instructions(user)
#     #from          "surya@vervesys.com"    
#     @account_activation_url = activate_account_url(user.perishable_token)
    
#     mail(:to => user.email_address_with_name,
#          :subject => "Activation Instructions",
#          :from => from,
#          :fail_to => from
#     ) do |format|
#       format.text
#     end
#   end

#   def activation_confirmation(user)
#     #from          "surya@vervesys.com"
    
#     mail(:to => user.email_address_with_name,
#          :subject => "Activation Complete",
#          :from => from,
#          :fail_to => from
#     ) do |format|
#       format.text
#     end
#   end

end
