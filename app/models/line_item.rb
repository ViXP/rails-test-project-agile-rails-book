class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  def total_price
  	if price
			price * quantity
		else
			product.price * quantity
		end
	end
end
