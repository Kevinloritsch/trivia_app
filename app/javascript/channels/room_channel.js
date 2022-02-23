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
        if(document.getElementById("player") != null){
          player = document.getElementById("player").innerText.toString()
        }
        if(document.location.pathname.includes("host")){
          this.send({host: document.getElementById("host").innerText})
          document.getElementById("play_button").addEventListener("click", function(){roomChannel.send({play: document.getElementById("triviagame_id").innerText})})
        }
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
        }else if(data.trivia_game != undefined){
          document.getElementById("container1").remove();
          var triv  = JSON.parse(data.trivia_game.toString())
          for(var i = 0; i < triv.length; i++){
            if(triv[i][0].toString().includes("question")){
              var question = document.createElement("h2")
              question.innerText = triv[i][1];
              document.getElementById("container").appendChild(question);
            }else if(triv[i][0].includes("frq")){
              var html = 
              `<div class="form-group row" onmouseout="this.children[0].value.toLocaleLowerCase() == '${triv[i][1]}'.toLocaleLowerCase() ? this.setAttribute('class', this.class + ' has-success has-feedback') : this.setAttribute('class', this.class + ' has-error has-feedback') " onmouseover="this.children[0].value.toLocaleLowerCase() == '${triv[i][1]}'.toLocaleLowerCase() ? this.setAttribute('class', this.class + ' has-success has-feedback') : this.setAttribute('class', this.class + ' has-error has-feedback') ">
                <input class="form-control" name="${triv[i][0]}">
               </div>`
               document.getElementById("container").innerHTML = document.getElementById("container").innerHTML + html;
              }else if(triv[i][0].toString().includes("answer")){
              var html = 
              `<div class="row" style="padding: 2px">
                <div class="col-md-6">
                  <button value="${triv[i][2]}" onclick="this.value == 'true' ? this.setAttribute('class','btn btn-success') : this.setAttribute('class','btn btn-danger')" class="btn btn-info">${triv[i][1]}</button>
                </div>
                <div class="col-md-6">
                  <button value="${triv[i+1][2]}" onclick="this.value == 'true' ? this.setAttribute('class','btn btn-success') : this.setAttribute('class','btn btn-danger')" class="btn btn-info">${triv[i+1][1]}</button>
                </div>
               </div>
               <div class="row" style="padding: 2px">
                <div class="col-md-6">
                  <button value="${triv[i+2][2]}" onclick="this.value == 'true' ? this.setAttribute('class','btn btn-success') : this.setAttribute('class','btn btn-danger')" class="btn btn-info">${triv[i+2][1]}</button>
                </div>
                <div class="col-md-6">
                  <button value="${triv[i+3][2]}" onclick="this.value == 'true' ? this.setAttribute('class','btn btn-success') : this.setAttribute('class','btn btn-danger')" class="btn btn-info">${triv[i+3][1]}</button>
                </div>
               </div>`
              document.getElementById("container").innerHTML = document.getElementById("container").innerHTML + html;
              i=i+3
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