module ApplicationHelper
	def hidden_div_if(answer, attrib = {}, &block)
		if answer 
			attrib["style"] = "display: none"
		end
		content_tag("div", attrib, &block)
	end

end
