class RoomChannel < ApplicationCable::Channel
  $remove_player = nil;
  $current_user = nil;
  def subscribed
    stream_from "room_channel_#{params["room"].to_s}"
  end

  def unsubscribed
    ActionCable.server.broadcast("room_channel_nymxurgc", delete: User.find($remove_player.to_i).name)
    players = Room.find_by(:session=>params["room"]).players.split(", ");
    players.delete($remove_player)
    # puts(players);
    Room.find_by(:session=>params["room"].to_s).update(players: players.join(", ").to_s);
  end
  def receive(data)
    # puts(data["id"].to_i.class)
    if(data["id"] != nil)
      ActionCable.server.broadcast("room_channel_#{params["room"].to_s}", player: User.find(data["id"].to_i).name.to_s)
    end
      $remove_player = data["player"]
  end
end
