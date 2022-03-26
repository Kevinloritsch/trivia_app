class RoomChannel < ApplicationCable::Channel
  $remove_player = nil;
  $current_user = nil;
  $host = nil
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
    if(data["message"] != nil)
      ActionCable.server.broadcast("room_channel_#{params["room"].to_s}", message: data["message"].to_s)
    end
    if(data["id"] != nil)
      ActionCable.server.broadcast("room_channel_#{params["room"].to_s}", player: User.find(data["id"].to_i).name.to_s)
    end
    if(data["host"] != nil)
      $host = data["host"].to_i
    end
    if(data["play"] != nil)
      trivia_games = Array.new;
      TriviaGame.where(author: User.find($host).email).find_each do |trivia_game|
        trivia_games.append(trivia_game);
      end
      host_trivia_game = trivia_games[data["play"].to_i]
      # ActionCable.server.broadcast("room_channel_#{params["room"].to_s}", message: host_trivia_game.data)
      ActionCable.server.broadcast("room_channel_#{params["room"].to_s}", trivia_game: host_trivia_game.data)
    end
    ActionCable.server.broadcast("room_channel_#{params["room"].to_s}", message: data["player"])
    if(data["player"] != nil)
      $remove_player = data["player"]
    end
    if(data["player"].to_s == "Host has disconnected from room")
      Room.find_by(:session=>params["room"].to_s).delete
    end
  end
end
