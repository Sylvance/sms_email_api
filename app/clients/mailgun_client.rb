class MailgunClient
  def self.client_instance
    @client_instance ||= new.client_instance
  end

  def initialize
    @mailgun_api_key = Settings.development.mailgun_api_key
  end

  def client_instance
    @client_instance ||= Mailgun::Client.new(@mailgun_api_key)
  end
end
