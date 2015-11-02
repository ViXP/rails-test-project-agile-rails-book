require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
	fixtures :products
  # test "the truth" do
  #   assert true
  # end

  test "do order" do
  	LineItem.delete_all
  	Order.delete_all
  	ruby_book = products(:ruby)

  # ADD PRODUCTS TO CART
  	get "/"
  	assert_response :success
  	assert_template "index"
    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

  # ADD ORDER
    get "/orders/new"
    assert_response :success
    assert_template "new"
    post_via_redirect "/orders",
                      order: {name: "Cyril ViXP",
                              address: "123 The Street", 
                              email: "cyrilvixp@gmail.com",
                              pay_type: "Check"}
    assert_response :success
    assert_template "index"

  # CART MUST BE DESTROYED
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.count

  # ORDER MUST BE CREATED
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
    assert_equal "Cyril ViXP", order.name
    assert_equal "123 The Street", order.address
    assert_equal "cyrilvixp@gmail.com", order.email
    assert_equal "Check", order.pay_type
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

  # MAILER TEST
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["cyrilvixp@gmail.com"], mail.to
    assert_equal 'Order confirmation from Projject store', mail.subject
  end
end
