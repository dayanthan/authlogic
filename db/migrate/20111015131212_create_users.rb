class CreateUsers < ActiveRecord::Migration
  def change
 create_table :users,:primary_key => :user_id do |t|
	t.string	:first_name ,   :limit => 100
      	t.string      	:last_name,     :limit => 100
      	t.string      	:gender,        :limit => 100
      	t.string      	:birthdate,     :limit => 100
      	t.string      	:email
      	t.string	      :username
		    t.boolean     	:user_type, :comment => " 0-Admin, 1-User"
      	t.string      	:crypted_password  
      	t.string      	:password_salt
      	t.string      	:persistence_token
      	t.string      	:perishable_token
        t.references  	:country
	      t.references  	:state
	      t.string      	:city,		:limit => 100
      	t.string      	:zipcode
  	    t.boolean     	:is_active,     :default => 1    ,:comment=>"1 for Active, 2 for Inactive"
      	t.string      	:reset_code
      	t.datetime    	:photo_updated_at
      t.timestamps
    end
  end
end
