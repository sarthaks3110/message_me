class MessagesController < ApplicationController
  before_action :require_user

  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      ActionCable.server.broadcast("chatroom_channel", {
        message_html: ApplicationController.render(
          partial: "messages/message",
          locals: { message: @message }
        )
      })
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("flash", partial: "shared/flash", locals: { alert: "Message cannot be blank." }), status: :unprocessable_entity }
        format.html { redirect_to root_path, alert: "Message cannot be blank." }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
