class StoreController < ApplicationController	
	include PageVisits
  def index
  	@products = Product.order(:title)
  end
end
