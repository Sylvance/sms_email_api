class CommunicationsController < ApplicationController
  def send_communication
    res = MessageSender.send_message(
      from: params[:from],
      to: params[:to],
      subject: params[:subject],
      message: params[:message],
      medium: params[:medium]
    )

    render json: res.to_h
  end
end
