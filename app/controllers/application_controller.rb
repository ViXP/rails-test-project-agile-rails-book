class ApplicationController < ActionController::Base
	include CurrentCart, PageVisits
	before_action :set_cart
	before_action :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 skip_before_filter :verify_authenticity_token  

 	protected 

 	def authorize
 		unless User.find_by(id: session[:user_id])
 			redirect_to login_url, notice: "Please authorize yourself"
 		end
 	end
end
