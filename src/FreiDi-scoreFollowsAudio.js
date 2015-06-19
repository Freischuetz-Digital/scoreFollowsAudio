/*
 * FreiDi-scoreFollowsAudio
 * Copyright Benjamin W. Bohl, Laurent Pugin 2014
 * bohl(at)edirom.de
 * 
 * https://github.com/Freischuetz-Digital/scoreFollowsAudio
 * 
 * ## Description & License
 * 
 * This file implements the core functionality of FreiDi-scoreFollowsAudio
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

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
 * global variables
 */
 
 var globalTime = 0;

 /*
 * used functions
 */

function switchAudio(url,currentTime, newAudioID){
  console.log('switch audio');
  console.log(url);
  console.log('Old time ' + currentTime);
  
  var audio = $('#track');
  audio.attr('src', url);
  audio[0].currentTime = everpolate.linear(currentTime, mat_startTimes[audioNum], mat_startTimes[newAudioID])[0]; 
  audio.bind('canplay', function() {
   // console.log('New time '  + audio[0].currentTime);
   audio[0].play();
   audioNum = newAudioID;
   });   


};

function updateAudioTimes(currentTime, source){
  
};

/**
 * get image URI, measure number, measure ID from JSON based on input time
 * @param      {Number}   time from audio player
 * @var        {Number}   bestDiff
 */
function getMeasure(time){
//  console.log(time);
  var bestDiff = 0;
  var minDiff;
  var i;
  var cur;

  var imageUri;
  var measureID;
  var measureNumber;
  var measureCount;
  var measureIndex;
  
  // Compute exact measure position by interpolation
  measurePosition = everpolate.linear(time, mat_startTimes[audioNum], measures)[0];
  // Compute measure number (measureCount)
  measureCount    = Math.floor( measurePosition );
  measureIndex    = measureCount-1;
  if(measureIndex >= 0){
    imageUri = json.measures[measureIndex].page;
    checkImage(imageUri);
    measureID = json.measures[measureIndex].measureID;  
  }
  else{
    measureIndex = 0;
  };
  //set facsimile text field to new value
  $('#facsimileID').text(imageUri);
  //set measure count to new value
  //$("#measureCount").text(measureCount);
  //set measure position to new value
  //$("#measurePosition").text(measurePosition.toFixed(3));
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