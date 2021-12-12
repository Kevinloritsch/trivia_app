import consumer from "./consumer"
document.addEventListener('turbolinks:load', ()=> {
  var room_id = ''
  for(var i = window.location.href.length-1; i >= 0; i--){
      if(window.location.href[i] == '/'){
        break;
      }
      room_id += window.location.href[i]
  }
  console.log(room_id.split("").reverse().join(""))
  if(room_id.split("").reverse().join("") != 'play'){
    consumer.subscriptions.create({channel: "RoomChannel", room_id: room_id}, {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log("Connected to room channel...")
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    
      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log(data);
      }
    });
  }
})
