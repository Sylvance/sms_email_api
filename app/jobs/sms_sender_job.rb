class SmsSenderJob < ApplicationJob
  queue_as :messages

  def perform(message_id)
    sms = Message.find_by(id: message_id)

    send_sms(sms.to, sms.body)

    sms.received_at = Time.now
    sms.save!
  end

  private

  def send_sms(to, message)
    SmsClient.send_message(to: to, message: message)
  end
end
