class Message < ApplicationRecord
  after_create_commit :enqueue_job

  private

  def enqueue_job
    SmsSenderJob.perform_later(self.id)
  end
end
