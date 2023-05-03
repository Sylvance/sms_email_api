class TwilioClient
  attr_reader :twilio_phone_number

  def self.client_instance
    @client_instance ||= new.client_instance
  end

  def initialize
    @twilio_account_sid = Settings.development.twilio_account_sid
    @twilio_auth_token = Settings.development.twilio_auth_token
    @twilio_phone_number = Settings.development.twilio_phone_number
  end

  def client_instance
    @client_instance ||= Twilio::REST::Client.new(
      @twilio_account_sid,
      @twilio_auth_token
    )
  end
end
