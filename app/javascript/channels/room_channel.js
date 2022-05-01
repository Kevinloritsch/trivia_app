import e from "turbolinks";
import consumer from "./consumer"
var roomChannel;
var room_id;
var player;
var trivia = 0;
var players;
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
        if(document.getElementById("players") === undefined || document.getElementById("players") === null){
        }else{
          players = document.getElementById("players")
        }
        // Called when there's incoming data on the websocket for this channel
        if(data.message != undefined){
          // console.log("Incoming Data: " + data.message.toString())
            if(location.pathname.includes("host")){
              document.getElementById("container").innerHTML = ""
              // console.log(typeof(data.message))
              var canvas = document.createElement("canvas");
              canvas.id = "myChart"
              canvas.style = "width:100%;max-width:700px"
              document.getElementById("container").append(canvas)
              barGraph(players, JSON.parse(data.message)[0], JSON.parse(data.message)[1],trivia, JSON.parse(data.message)[2])
          }
        }else if(data.player != undefined){
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
          for(var i= 0; i < players.children.length; i++){
            if(players.children[i].innerText == data.delete){
              players.children[i].remove()
              break;
            }
          }
        }else if(data.trivia_game != undefined){
          for(var i = 0; i < JSON.parse(data.trivia_game).length; i++){
            if(JSON.parse(data.trivia_game)[i][0].includes("question")){
              trivia++;
            }
          }
          document.getElementById("container1").remove();
          if(player == undefined){
            var canvas = document.createElement("canvas");
            canvas.id = "myChart"
            canvas.style = "width:100%;max-width:700px"
            document.getElementById("container").append(canvas)
            barGraph(players, null,null,trivia, null);
          }else{
            var triv  = JSON.parse(data.trivia_game.toString())
            var buttons = [];
            var row = [];
            var cols = [];
            row[0] = document.createElement("div")
            row[0].className = "form-group row"
            row[1] = document.createElement("div")
            row[1].className = "row"
            if(triv[0][0].includes("frq")){
              row[0].innerHTML = `<div class="col"><input name="${triv[0][0]}" type="text" class="form-control"></div>`
              var html = 
              `
              <div class="row">
              <h2 id="${triv[0][0]}">${triv[0][1]}</h2>
              </div>`
              var col = document.createElement("div")
              col.className = "col-md-1 col-md-offset-11";
              var button = document.createElement("button");
              button.className = "btn btn-info"
              button.innerText = "Submit"
              button.onclick = function(){test_function(this, triv, roomChannel)}
              document.getElementById("container").innerHTML = html;
              document.getElementById("container").appendChild(row[0])
              col.appendChild(button);
              row[1].appendChild(col);
              document.getElementById("container").appendChild(row[1]);
              

            }else{
              for(var counter = 0; counter < 4; counter++){
                var col = document.createElement("div")
                col.className = "col-md-6"
                buttons[counter] = document.createElement("button");
                buttons[counter].id = triv[counter+1][0]
                buttons[counter].innerHTML = triv[counter+1][1].toString()
                buttons[counter].value = triv[counter+1][2]
                buttons[counter].className = "btn btn-info"
                if(buttons[counter].value == 'true'){
                  buttons[counter].onclick = function(){this.setAttribute('class', 'btn btn-success'),right++,test_function(this, triv, roomChannel)}
                }else{
                  buttons[counter].onclick = function(){this.setAttribute('class', 'btn btn-danger'),wrong++}
                }
                col.appendChild(buttons[counter])
                if(counter < 2){
                  row[0].appendChild(col);
                }else{
                  row[1].appendChild(col);
                }

              }
            
              var html = 
              `
              <div class="row">
              <h2 id="${triv[0][0]}">${triv[0][1]}</h2>
              </div>`

                document.getElementById("container").innerHTML = html;
                document.getElementById("container").appendChild(row[0])
                document.getElementById("container").appendChild(row[1])
                // i=i+3
            }
          }

        }
      }
    });
  }else if(roomChannel != null){
    // console.log(player)
    if(player == undefined){
      roomChannel.send({player: "Host has disconnected from room"})
    }else{
      roomChannel.send({ player:  player})
    }  
    roomChannel.disconnected()
    roomChannel = null
  }
})