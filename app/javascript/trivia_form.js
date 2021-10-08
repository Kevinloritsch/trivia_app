var counter = 0;
  var frq_counter = 0;
  function create_mutiplechoice() {
    counter++;
    var mutiple_choice = document.createElement("div");
    mutiple_choice.id = `mutiplechoice${counter}`;
    mutiple_choice.innerHTML = `
  <div class="row">
    <div class="col-md-12">
      <label>Question</label>
      <input type="text" class="form-control" placeholder="Question">
    </div>
    </div>
      <div class="row">
        <div class="col-md-6">
          <label>A.</label>
          <input type="text" class="form-control" placeholder="A.">
        </div>
        <div class="col-md-6">
          <label>B.</label>
          <input type="text" class="form-control" placeholder="B.">
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <label>C.</label>
          <input type="text" class="form-control" placeholder="C.">
        </div>
        <div class="col-md-6">
          <label>D.</label>
          <input type="text" class="form-control" placeholder="D.">
        </div>
      </div>
    `
    var row = document.getElementById("questionsrow");
    row.appendChild(mutiple_choice);
  }
  function create_frq(){
    var frq = document.createElement("div");
    frq.id = `frq${frq_counter}`
    frq.innerHTML = 
    `
    <div class="row">
      <div class="col-md-6">
        <label>Question</label>
        <input type="text" class="form-control" placeholder="Question">
      </div>
      <div class="col-md-6">
        <label>Answer</label>
        <input type="text" class="form-control" placeholder="Answer">
      </div>
    </div>`;
    var row = document.getElementById("questionsrow");
    row.appendChild(frq);
  }