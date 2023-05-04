require 'rails_helper'

RSpec.describe CommunicationsController, type: :controller do
  describe 'POST send_communication' do
    let(:from) { 'sender@example.com' }
    let(:to) { 'recipient@example.com' }
    let(:subject) { 'Test message' }
    let(:message) { 'This is a test message' }
    let(:medium) { 'email' }
  
    it 'returns a successful response' do
      allow(MessageSenderService).to receive(:send_message).with(
        from: from,
        to: to,
        subject: subject,
        message: message,
        medium: medium
      ).and_return({ success: true })

      post :send_communication, params: {
        from: from,
        to: to,
        subject: subject,
        message: message,
        medium: medium
      }

      expect(response).to be_successful
      expect(JSON.parse(response.body)).to eq({ 'success' => true })
    end
  end
end
