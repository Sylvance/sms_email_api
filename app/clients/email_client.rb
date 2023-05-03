class EmailClient
  attr_reader :message, :from, :to, :subject, :third_party_client

  def self.send_message(from:, to:, message:, subject:)
    new(from, to, message, subject).send_message
  end

  def initialize(from, to, message, subject)
    @message = message
    @from = from
    @to = to
    @subject = subject
    @third_party_client = Mailgun.client_instance
  end

  def send_message
    message_params = {
      from: from,
      to: to,
      subject: subject,
      text: message
    }

    third_party_client.send_message(Settings.development.mailgun_domain, message_params)
  end
end
