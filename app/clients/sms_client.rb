class SmsClient
  attr_reader :message, :to, :third_party_client

  def self.send_message(to:, message:)
    new(to, message).send_message
  end

  def initialize(to, message)
    @message = message
    @to = to
    @third_party_client = TwilioClient.client_instance
  end

  def send_message
    third_party_client.messages.create(
      from: third_party_client.twilio_phone_number,
      to: to,
      body: message
    )
  end
end
