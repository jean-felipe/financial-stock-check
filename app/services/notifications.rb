require 'sendgrid-ruby'
include SendGrid

class Notifications < BaseService

  # This service send notifications to users
  # To initialize you should send some inputs:
  # 1 - An array with values[drawdown, stock_return, stock_symbol]
  # 2 - User info, user info, e.g (email address, twitter profile, whatsapp number)
  # 3 - Type of notification e.g email, whatsapp, twitter.
  #

  def initialize(values:, user_info:, type:)
    @values = values
    @user_info = user_info
    @type = type
  end

  def process!
    set_notification_type
  end

  private

  def set_notification_type
    send_email_notification
  end

  def send_email_notification
    from = Email.new(email: 'mandakeru@gmail.com')
    to = Email.new(email: @user_info)
    subject = 'Your Stock return and Drawdown data.'
    content = Content.new(type: 'text/plain', value: "Hello! \n Stock Symbol: #{@values[2]}\n Drawdown percentage: #{@values[0]}%\n 
      Stock Return percentage: #{@values[1]}%\n hope see you again!")
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV.fetch('SENDGRID_API_KEY'))
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    if response.status_code == "202"
      puts "Email sent successfully! see you!"
    else
      puts "something went wrong please try again."
      puts response.status_code
      puts response.body
      puts response.headers
    end
  end
end