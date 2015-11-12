module OrdersHelper

	def pay_types_translate
	# returns the array of payment types in form of: value: DB-value, text: text value 
		result = []
		PaymentType.names.each do |type|
			result << { :value => type, :text => I18n::t(type.downcase.gsub(/\s+/, "")) }
		end
		result
	end

end
