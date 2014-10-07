/*
 * not used
 */
function appendAudio() {
  var audio = new Audio();
  audio.id = 'track_js'
  audio.src = 'http://localhost:8000/Weber_Freischuetz-06_FreiDi.mp3';
  audio.controls = true;
  document.getElementById("audioDiv").appendChild(audio);
  console.log('audio appended');
};
/*
 * used
 */

function getMeasure(time){
  var bestDiff = 0;
  var minDiff;
  var bestIndex;
  var i;
  var cur;
  for (i=0; i < json.measures.length; i++){
  
    cur = json.measures[i];
    diff = cur.timestamp - time;
    /*console.log(cur.timestamp);
    console.log(diff);*/
    if(diff < bestDiff){
      minDiff = diff;
      bestIndex = i; 
    }
  }
  var imageUri = json.measures[0].page;
  var measureID;
  var measureCount;
  if(bestIndex >= 0){
    imageUri = json.measures[bestIndex].page;
    measureID = json.measures[bestIndex].measureID;
    measureCount = bestIndex + 1;//+1 um die tatsächliche Taktzahl zu errechnen
  };
  checkImage(imageUri);
  $('#facsimileID').text(imageUri);
  $("#measureCount").text(measureCount);
  $("#measureID").text(measureID);
  /*console.log("bestIndex: ");
  console.log(bestIndex);
  console.log("minDiff: ");
  console.log(minDiff);*/
};

function checkImage(imageUri) {
  if (currentImageUri !== imageUri){
    setImage(imageUri, 'myCanvas');
  }
};

function setImage(imageUri, targetID){
  currentImageUri = imageUri;
  /*var c = document.getElementById('myCanvas');
  var ctx = c.getContext("2d");
  var img =  document.getElementById('currentImage');
  ctx.drawImage(img,10,10);*/
  document.getElementById('currentImage').src = 'http://freischuetz-digital.de/digilib/Scaler/freidi/'+imageUri+'?dw=710&amp;mo=fit';
};


/*
 * research
 */
/*var mediaElement = document.getElementById('track');
mediaElement.seekable.start();  // Returns the starting time (in seconds)
mediaElement.seekable.end();    // Returns the ending time (in seconds)
mediaElement.currentTime = 122; // Seek to 122 seconds
mediaElement.played.end();      // Returns the number of seconds the browser has played*/