require 'test_helper'

class AdminNotifierTest < ActionMailer::TestCase
  test "error message must be send" do
    mail = AdminNotifier.error_occured("Error message text")
    assert_equal "Error occured in your application", mail.subject
    assert_equal ["cyrilvixp@gmail.com"], mail.to
    assert_match "Error message text", mail.body.encoded
  end
end
