/*
 * unused functions
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
 * used functions
 */

/**
 * get image URI, measure number, measure ID from JSON based on input time
 * @param      {Number}   time from audio player
 * @var        {Number}   bestDiff
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
  
  //call function to check current image against the one associated with best match
  checkImage(imageUri);
  //set facsimile text field to new value
  $('#facsimileID').text(imageUri);
  //set measure count to new value
  $("#measureCount").text(measureCount);
  //set measure ID to new value
  $("#measureID").text(measureID);
  
  return measureID;
};

 /**
 * check if submitted image URI equals current image URI
 * @param      {String}   imageURI image URI from JSON to be checked against currently visible images URI
 */
function checkImage(imageUri) {
  if (currentImageUri !== imageUri){
    setImage(imageUri, 'currentImage');
  }
};

 /**
 * set an img elements src attribute to supplied URI
 * @param      {String}   imageUri new image URI
 * @param      {String}   targetID ID of the target img element
 */
function setImage(imageUri, targetID){
  currentImageUri = imageUri;
  document.getElementById(targetID).src = 'http://freischuetz-digital.de/digilib/Scaler/freidi/'+imageUri+'?dw=710&amp;mo=fit';
};


/*
 * research
 */
/*var mediaElement = document.getElementById('track');
mediaElement.seekable.start();  // Returns the starting time (in seconds)
mediaElement.seekable.end();    // Returns the ending time (in seconds)
mediaElement.currentTime = 122; // Seek to 122 seconds
mediaElement.played.end();      // Returns the number of seconds the browser has played*/