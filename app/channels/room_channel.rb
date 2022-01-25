class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params["room"].to_s}"
    # ActionCable.server.broadcast("room_channel_#{params[:room]}", message: "hello")

  end

  def unsubscribed
    
  end
  def receive(data)
    ActiveCable.server.broadcast("room_channel_#{data.sent_by.to_s}", message: data.body.to_s)
  end
end
