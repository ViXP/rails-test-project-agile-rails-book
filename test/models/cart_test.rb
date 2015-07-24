require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def new_cart product_cur
  	cart = Cart.create
  	cart.add_product(product_cur.id, product_cur.price)
    cart
  end

  test "new line in the cart" do
  	cart = new_cart(products(:one))
  	assert_equal 1, cart.line_items.count
  	cart.add_product(products(:ruby).id, products(:ruby).price)
  	assert_equal 2, cart.line_items.count
	end

	test "update existing line item in cart" do
		cart = new_cart(products(:one))
		cart.add_product(products(:one).id, products(:one).price)
		assert_equal 1, cart.line_items.count
	end

end
