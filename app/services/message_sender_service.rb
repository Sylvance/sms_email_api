class MessageSenderService
  attr_reader :from, :to, :subject, :message, :medium

  Response = Struct.new(:data, :message, :error, :success?, keyword_init: true)

  def self.send_message(from: nil, to:, subject: nil, message:, medium:)
    new(from, to, subject, message, medium).send_message
  rescue StandardError => e
    Response.new(data: {}, message: 'an error occurred', error: [e], success?: false)
  end

  def initialize(from, to, subject, message, medium)
    @from = from
    @to = to
    @subject = subject
    @message = message
    @medium = medium
  end

  def send_message
    validator = validator_call
    data = { from: from, to: to, message: message, subject: subject, medium: medium}

    if validator.success?
      send_message_via_client

      Response.new(data: data, message: 'message sent', error: [], success?: true)
    else
      Response.new(data: data, message: validator.message, error: validator.error, success?: validator.success?)
    end
  end

  private

  def validator_call
    MessageSenderValidator.validate(
      from: from, to: to, message: message, subject: subject, medium: medium
    )
  end

  def send_message_via_client
    case medium.to_sym
    when :sms
      send_sms if created_message_in_db
    when :email
      send_email if created_email_in_db
    else
      nil
    end
  end

  def send_sms
    SmsClient.send_message(to: to, message: message)
  end

  def send_email
    EmailClient.send_message(
      from: from, to: to, message: message,
      subject: subject
    )
  end

  def created_message_in_db
    now = Time.now

    Message.create(
      from: from, to: to, body: message, subject: subject,
      medium: medium, is_received: true, sent_at: now, received_at: now
    )
  end

  def created_email_in_db
    now = Time.now

    Email.create(
      from: from, to: to, body: message, subject: subject,
      medium: medium, is_received: true, sent_at: now, received_at: now
    )
  end
end
