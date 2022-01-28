class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params["room"].to_s}"
    # ActionCable.server.broadcast("room_channel_#{params[:room]}", message: "hello")

  end

  def unsubscribed
    players = Room.find_by(:session=>params["room"]).players.split(", ");
    players.pop
    Room.find_by(:session=>params["room"].to_s).update(players: players.join(", "));
  end
  def receive(data)
  end
end
