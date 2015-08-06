class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  def total_price
  	if price
			price * quantity
		else
			product.price * quantity
		end
	end

	def decrement
		if(self.quantity > 1) 
      self.quantity -= 1
    else
    	self.destroy
  	end
  	self
	end

end
