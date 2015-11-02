require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase

  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal 'Order confirmation from Projject store', mail.subject
    assert_equal ["cyrilvixp@gmail.com"], mail.to
    assert_match /2 x CoffeeScript/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "We sent your order!", mail.subject
    assert_equal ["cyrilvixp@gmail.com"], mail.to
    assert_match /2 x CoffeeScript/, mail.body.encoded
  end

end
