import consumer from "./consumer"
var roomChannel;
var room_id;
var player;
document.addEventListener('turbolinks:load', ()=> {
  if(document.getElementById("gamesession") != null){
      room_id = document.getElementById('gamesession').innerText
      roomChannel = consumer.subscriptions.create({channel: "RoomChannel", room: room_id}, {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log("Connecting from room channel: "+ room_id.toString())
        player = document.getElementById("player").innerText.toString()
      },
    
      disconnected() {
        this.unsubscribe();
        // this.send({ sent_by: "room_channel_"+room_id.toString(), body: "This is a cool chat app." })
        console.log("Disconnected from room channel...")
        // Called when the subscription has been terminated by the server
      },
    
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log("Incoming Data: " + data.message.toString());
        // document.getElementById("players").innerText = document.getElementById("players").innerText + data.message.toString()+ "\n";
      }
    });
  }else if(roomChannel != null){
    console.log(player);
    roomChannel.send({ player:  player})
    roomChannel.disconnected()
    roomChannel = null
  }
})