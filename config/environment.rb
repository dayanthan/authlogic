# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Forgot::Application.initialize!
#config.action_mailer.default_url_options = { :host => "localhost:3000" }

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
#ActionMailer::Base.default_charset = "utf-8"
#ActionMailer::Base.raise_delivery_errors = true
#ActionMailer::Base.default_content_type = "text/html"


  

ActionMailer::Base.smtp_settings = {
  :address => "smtpout.secureserver.net",
  :port => 25,
  :domain => "gmail.com",
  :authentication => :plain,
  :user_name => "surya@vervesys.com",
  :password => "sur^key264$",
  :enable_starttls_auto => true
  
}


