require 'digest/sha1'
class User < ActiveRecord::Base

  acts_as_authentic do |c|
    c.login_field = :email
  end
  
  set_primary_key :user_id
  
  attr_accessible :username,:email,:password,:password_confirmation,:gender,:first_name,:last_name,:user_type,:old_password

  validates :username, :presence => true, 
                       :length => { :within => 3..20 }, 
                       :uniqueness => true, 
                       :format => { :with => /\A[a-z0-9][a-z0-9\-]+[a-z0-9]\z/ }

  validates :email, :presence => true, 
                    :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, 
                    :uniqueness => { :case_sensative => false },
                    :length => { :maximum => 255 }

  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 

  #delegate :url_helpers, to: 'Rails.application.routes' 

  def url
    url_helpers.thing_path(self)
  end

  #include Rails.application.routes.url_help

  def active?
    active
  end

  def activate!
    self.active = true
    save
  end

  def deactivate!
    self.active = false
    save
  end

  def send_activation_instructions!
    reset_perishable_token!
    UserMailer.activation_instructions(self).deliver
  end

  def send_activation_confirmation!
    reset_perishable_token!
    UserMailer.activation_confirmation(self).deliver
  end

# def email_address_with_name
#   "#{self.name} <#{self.email}>"
# end


  def send_forgot_password!
    deactivate!
    reset_perishable_token!
    UserMailer.forgot_password(self).deliver
  end

#        def create_reset_code
#	    @reset = true
#	    self.reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
#	    save
#	  end 
	  
	  def recently_reset?
	    @reset
	  end 

	  def delete_reset_code
	    self.attributes = {:reset_code => nil}
	    save(false)
	  end
end
