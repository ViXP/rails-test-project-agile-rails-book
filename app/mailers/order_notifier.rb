class OrderNotifier < ActionMailer::Base
  default from: "Cyril ViXP <cyrilvixp@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received order
    @order = order
    @greeting = 'Hi!'
    mail to: order.email, subject: 'Order confirmation from Projject store'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped order
    @order = order
    @greeting = 'Hi!'
    mail to: order.email, subject: "We sent your order!"
  end 

  def updated order
    @order = order
    @greeting = "Hi!"
    @ship_date = order.ship_date
    mail to: order.email, subject: "Your shipping date changed"
  end

end
