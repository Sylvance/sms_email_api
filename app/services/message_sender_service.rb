class MessageSenderService
  attr_reader :from, :to, :subject, :message, :medium

  Response = Struct.new(:data, :message, :error, :success?, keyword_init: true)

  def self.send_message(from: nil, to:, subject: nil, message:, medium:)
    new(from, to, subject, message, medium).send_message
  end

  def initialize(from, to, subject, message, medium)
    @from = from
    @to = to
    @subject = subject
    @message = message
    @medium = medium
  end

  def send_message
    validator = MessageSenderValidator.validate(
      from: from, to: to, message: message, subject: subject, medium: medium
    )

    if validator.success?
      send_message_via_client

      Response.new(
        data: { from: from, to: to, message: message, subject: subject, medium: medium},
        message: 'message sent', error: [], success?: true
      )
    else
      Response.new(
        data: { from: from, to: to, message: message, subject: subject, medium: medium},
        message: validator.message, error: validator.error, success?: validator.success?
      )
    end
  rescue Error, StandardError => e
    Response.new(data: {}, message: 'an error occurred', error: [e], success?: false)
  end

  private

  def send_message_via_client
    case medium.to_sym
    when :sms
      SmsClient.send_message(to: to, message: message)
    when :email
      EmailClient.send_message(from: from, to: to, message: message, subject: subject)
    else
      nil
    end
  end
end
