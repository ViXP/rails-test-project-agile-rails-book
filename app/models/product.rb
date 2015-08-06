class Product < ActiveRecord::Base
	has_many :line_items
	has_many :orders, through: :line_items
	before_destroy :referenced_by_line_item?

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {:greater_then_or_equal_to => 0.01}
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: ({
		:with => %r{\.(gif|jpg|jpeg|png)\Z}i, 
		:message => 'URL must point to the image'})

	def self.latest
		Product.order(:updated_at).last
	end

	private

	def referenced_by_line_item?
		unless line_items.empty?
			errors.add(:base, 'line items already exist')
			return false
		else
			return true
		end
	end
	
end
