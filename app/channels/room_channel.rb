class RoomChannel < ApplicationCable::Channel
  $remove_player = nil;
  def subscribed
    stream_from "room_channel_#{params["room"].to_s}"
    # ActionCable.server.broadcast("room_channel_#{params[:room]}", message: "hello")

  end

  def unsubscribed
    # ActionCable.server.broadcast("room_channel_nymxurgc", message:"help")
    players = Room.find_by(:session=>params["room"]).players.split(", ");
    players.delete($remove_player)
    # puts(players);
    Room.find_by(:session=>params["room"].to_s).update(players: players.join(", ").to_s);
  end
  def receive(data)
    $remove_player = data["player"]
  end
end
