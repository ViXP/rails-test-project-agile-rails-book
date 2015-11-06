class ApplicationController < ActionController::Base
	include CurrentCart, PageVisits
	before_action :set_i18n_locale_from_params
  before_action :set_cart
	before_action :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 	skip_before_filter :verify_authenticity_token

 	protected 

 	def authorize
 		if !(User.find_by(id: session[:user_id])) && !(User.count.zero?)
 			if request.format == Mime::HTML
 				redirect_to login_url, notice: "Login please"
 			else
 				if user = authenticate_with_http_basic do |logn, pass|
          finded_user = User.find_by_name(logn)
          finded_user.authenticate(pass) if finded_user
        end
        session[:user_id] = user.id
        elsif
          render :status => 403, :text => "login failed" and return
        end
 			end
	  elsif User.count.zero?
			redirect_to new_user_url, notice: "Register your user"
		end
 	end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation is not available now, sorry"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

end
