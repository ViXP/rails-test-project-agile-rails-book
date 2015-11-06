require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest

  # test "the truth" do
  #   assert true
  # end

  test "do order" do
  	LineItem.delete_all
  	Order.delete_all
  	ruby_book = products(:ruby)

  # LOGIN
    post "/login", name: users(:one).name, password: 'groovy'
    assert_redirected_to admin_url

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
                              pay_type: "Check",
                              ship_date: (Time.now - 86000).to_date}
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
    assert_equal ["cyrilvixp@gmail.com"], last_mail.to
    assert_equal 'Order confirmation from Projject store', last_mail.subject

  # UPDATE SHIPPING DATE
    patch_via_redirect order_path(order), order: {name: "Cyril ViXP",
                              address: "123 The Street", 
                              email: "cyrilvixp@gmail.com",
                              pay_type: "Check",
                              ship_date: Time.now.to_date}    
    assert_response :success
    assert_template "index"
    assert_equal ["cyrilvixp@gmail.com"], last_mail.to
    assert_equal "Your shipping date changed", last_mail.subject
  end

  test "should mail admin" do
  # LOGIN
    post "/login", name: users(:one).name, password: 'groovy'
    assert_redirected_to admin_url

  # ERROR MAILER 
    get "/carts/cart_not_exist"
    assert_redirected_to store_url
    assert_equal ["cyrilvixp@gmail.com"], last_mail.to
    assert_equal "Error occured in your application", last_mail.subject
  end

  test "should require login" do
    # LOGIN
    post "/login", name: users(:one).name, password: 'groovy'
    assert_redirected_to admin_url
    get "/orders"
    assert_response :success
    assert_template "index"    
    delete_via_redirect "logout", session: {user_id: users(:one).id}
    assert_response :success
    get "/orders"
    assert_redirected_to "/login"
  end

  test "should require registration if no users" do
    User.delete_all
    get "/products"
    assert_redirected_to new_user_url
  end

end
