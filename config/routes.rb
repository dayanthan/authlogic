Forgot::Application.routes.draw do
  	get "users/new"
  	get "password_resets/new"
	  post "users/change_password"
  	get "user_sessions/new"
    match 'activate(/:activation_code)' => 'users#activate', :as => :activate_account
    match 'send_activation(/:user_id)' => 'users#send_activation', :as => :send_activation

  	match 'signup' => "users#new",             :as => :signup
  	match 'login' => "user_sessions#new",      :as => :login 
  	match 'logout' => "user_sessions#destroy", :as => :logout
	  match '/users/forgot_password/'=> "users#forgot_password", :as => :forgot_password
    match '/users/updatepassWithEmail'=>"users#updatepassWithEmail",:action=>'updatepassWithEmail'
   	match '/newpass/:reset_code' =>"users#newpass", :as => :newpasss
    match '/users/reset_pass'=>'users#reset_pass' ,:as => :reset_pass
    match 'user/changepwd/' =>"users#changepwd", :as => :changepwd
    match '/users/updatechangepwd/'=>'users#updatechangepwd' ,:as => :updatechangepwd
	  match '/users/change_password/'=>'users#change_password' ,:as => :change_password
    match '/home/checkusernamedata/'=> "home#checkusernamedata", :as => :checkusernamedata
    match '/home/checkemaildata/'=> "home#checkemaildata", :as => :checkemaildata
	#map.change_password '/change_password', :controller => 'users', :action => 'change_password'
 	#The priority is based upon order of creation:
        #first created -> highest priority.
	root :to => "home#index"
	resources :user_sessions
	resources :users
  resources :home

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
