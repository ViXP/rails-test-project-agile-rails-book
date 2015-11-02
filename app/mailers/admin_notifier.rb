class AdminNotifier < ActionMailer::Base
  default from: "cyrilvixp@gmail.com"

  def error_occured error
  	@error = error
  	mail to: "cyrilvixp@gmail.com", subject: "Error occured in your application"
  end
  
end
