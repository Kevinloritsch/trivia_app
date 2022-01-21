class RoomChannel < ApplicationCable::Channel < ApplicationController
  require current_user
  def subscribed
    stream_from "room_channel_#{params["room"].to_s}"
    # ActionCable.server.broadcast("room_channel_#{params[:room]}", message: "hello")

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  def receive(data)
 
  end
end
