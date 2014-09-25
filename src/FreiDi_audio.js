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
    console.log(cur.timestamp);
    console.log(diff);
    if(diff < bestDiff){
      minDiff = diff;
      bestIndex = i +1; //+1 um die tatsächliche Taktzahl zu errechnen
    }
  }
  $('#facsimileID').text(json.measures[bestIndex-1].page);
  $("#measureCount").text(bestIndex);
  console.log("bestIndex: ");
  console.log(bestIndex);
  console.log("minDiff: ");
  console.log(minDiff);
};

/*
 * research
 */
/*var mediaElement = document.getElementById('track');
mediaElement.seekable.start();  // Returns the starting time (in seconds)
mediaElement.seekable.end();    // Returns the ending time (in seconds)
mediaElement.currentTime = 122; // Seek to 122 seconds
mediaElement.played.end();      // Returns the number of seconds the browser has played*/