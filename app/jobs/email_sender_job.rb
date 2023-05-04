class EmailSenderJob < ApplicationJob
  queue_as :emails

  def perform(email_id)
    email = Email.find_by(id: email_id)

    send_email(email.from, email.to, email.body, email.subject)

    email.received_at = Time.now
    email.save!
  end

  private

  def send_email(from, to, message, subject)
    EmailClient.send_message(
      from: from, to: to, message: message,
      subject: subject
    )
  end
end
