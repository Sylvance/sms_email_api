class Email < ApplicationRecord
  after_create_commit :enqueue_job

  private

  def enqueue_job
    EmailSenderJob.perform_later(self.id)
  end
end
