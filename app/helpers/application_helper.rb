module ApplicationHelper
	def hidden_div_if(answer, attrib = {}, &block)
		if answer 
			attrib["style"] = "display: none"
		end
		content_tag("div", attrib, &block)
	end

	def local_price(price)
		params[:locale] == "en" ? price : price * 0.932821
	end

end
