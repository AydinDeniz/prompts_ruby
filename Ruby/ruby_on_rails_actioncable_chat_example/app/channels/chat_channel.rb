
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_room_\#{params[:room]}"
    current_user.update(online: true)
  end

  def unsubscribed
    current_user.update(online: false)
  end

  def receive(data)
    message = current_user.messages.create!(content: data['message'], room_id: params[:room])
    ActionCable.server.broadcast("chat_room_\#{params[:room]}", message: render_message(message))
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
