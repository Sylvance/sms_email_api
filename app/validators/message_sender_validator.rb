class MessageSenderValidator
  attr_reader :from, :to, :subject, :message, :medium

  Response = Struct.new(:message, :error, :success?, keyword_init: true)

  class UnknownMediumError < StandardError; end
  class InvalidTypeError < ArgumentError; end
  class InvalidPhoneNumberError < StandardError; end
  class InvalidEmailError < StandardError; end

  def self.validate(from: nil, to:, subject: nil, message:, medium:)
    new(from, to, subject, message, medium).validate
  rescue ArgumentError, Error, StandardError => e
    Response.new(message: e.message, error: [e], success?: false)
  end

  def initialize(from, to, subject, message, medium)
    @from = from
    @to = to
    @subject = subject
    @message = message
    @medium = medium
  end

  def validate
    raise UnknownMediumError, 'medium must be sms or email' unless [:sms, :email].include? medium.to_sym
    raise InvalidTypeError, 'medium must be a string' unless medium.is_a(String)
    raise InvalidTypeError, 'message must be a string' unless message.is_a(String)
    raise InvalidTypeError, 'subject must be a string' unless subject.is_a(String)

    if medium.to_sym == :sms
      raise InvalidPhoneNumberError, 'phone number must be valid' unless Phonelib.valid?(to)
    end

    if medium.to_sym == :email
      raise InvalidEmailError, 'email must be valid' unless Truemail.valid?(from, with: :regex)
      raise InvalidEmailError, 'email must be valid' unless Truemail.valid?(to, with: :regex)
    end

    Response.new(message: 'validation complete', error: [], success?: true)
  end
end
