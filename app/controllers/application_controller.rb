class ApplicationController < ActionController::Base
	include CurrentCart, PageVisits
	before_action :set_cart
	before_action :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 	skip_before_filter :verify_authenticity_token

 	protected 

 	def authorize
 		if !(User.find_by(id: session[:user_id])) && User.count > 0
 			redirect_to login_url, notice: "Login please"
	  elsif User.count == 0 
			redirect_to new_user_url, notice: "Register your user"
		end
 	end

end
