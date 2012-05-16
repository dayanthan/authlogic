class HomeController < ApplicationController
 # before_filter :require_user

  def index
  end

def checkusernamedata
   user=User.find_by_username(params[:username])

         if !user.nil?
          message= "username already present"
          respond_to do |format|
            format.html
            format.js{render :json => message }
        end
       else
        message="not present"
        end
 end


def checkemaildata
    user=User.find_by_email(params[:email])

    if !user.nil?
      message= "Email already present"
      respond_to do |format|
        format.html
        format.js{render :json => message }
      end
    else
      message="not present"
    end
  end

end
