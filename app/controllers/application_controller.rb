class ApplicationController < ActionController::Base
	include CurrentCart, PageVisits
	before_action :set_cart
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 skip_before_filter :verify_authenticity_token  
end
