class StoreController < ApplicationController
  def index
  	@products = Product.order(:title)
   session[:counter] = if session[:counter].nil? 
   	 1 
   	else
   	 session[:counter]+1
   	end
    @counter = session[:counter]
  end
end
