class CommunicationsController < ApplicationController
  # {
  # "to": "your_phone_number_or_email_here",
  # "method": "sms or email"
  # }
  def send_communication
    message = "Congratulations, your transaction is successful."
    twilio_account_sid = Settings.development.twilio_account_sid,
    twilio_auth_token = Settings.development.twilio_auth_token,
    twilio_phone_number = Settings.development.twilio_phone_number,
    mailgun_api_key = Settings.development.mailgun_api_key,
    mailgun_domain = Settings.development.mailgun_domain

    if params[:method] == 'sms'
      client = Twilio::REST::Client.new(
        twilio_account_sid,
        twilio_auth_token
      )

      client.messages.create(
        from: twilio_phone_number,
        to: params[:to],
        body: message
      )
    else
      mg_client = Mailgun::Client.new(mailgun_api_key)
      message_params = {
        from: 'Excited User <mailgun@YOUR_DOMAIN_NAME>',
        to: params[:to],
        subject: 'Congratulations!',
        text: message
      }

      mg_client.send_message(mailgun_domain, message_params)
    end

    render json: { message: message }
  end
end
