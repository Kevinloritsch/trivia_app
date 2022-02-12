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
        this.send({ id: player })
      },
    
      disconnected() {
        this.unsubscribe();
        console.log("Disconnected from room channel...")
        // Called when the subscription has been terminated by the server
      },
    
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        if(data.message != undefined){
          console.log("Incoming Data: " + data.message.toString());
        }else if(data.player != undefined){
          var players = document.getElementById("players");
          var boolean = true;
          for(var i = 0; i < players.children.length; i++){
            if(players.children[i].innerText.toString() == data.player){
              boolean = false
            }
          }
          if(boolean){
            var header = document.createElement("h2");
              header.innerText = data.player.toString();
              players.appendChild(header);
          }
        }else if(data.delete != undefined){
          // console.log("Delete Data:"+ data.delete)
          var players = document.getElementById("players")
          for(var i= 0; i < players.children.length; i++){
            if(players.children[i].innerText == data.delete){
              players.children[i].remove()
              break;
            }
          }
        }
      }
    });
  }else if(roomChannel != null){
    // console.log(player)
    roomChannel.send({ player:  player})
    roomChannel.disconnected()
    roomChannel = null
  }
})