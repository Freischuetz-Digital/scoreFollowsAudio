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
var comparisonKey = '';
var globalTime = 0;
var currentPage = 1;
var currentMeasure = undefined;
var leftBarLine = -1;
//set currentImage to default value
var currentImageUri;
//declare variable json
var json;
var mat_startTimes = [];
var measures = [];
var offline = true;

 /*
 * used functions
 */

/*function resetGlobalVars(){
  console.log('reset globals');
  audioNum ='';
  globalTime = 0;
  //var currentPage = 1;
  currentMeasure = undefined;
  leftBarLine = -1;
  json = [];
 };
*/ 
 /* function filterById
 * @param object   the JSON array to be searched
 * @param value    the ID value to be retrieved
 *
 * returns JSON object
 */
function getIndexById (object, value) {

    console.log('filter by id:');
    console.log(value);

  return $.map(object, function (item, key) { 

      // this is where the check is done
      if (item.comparisonKey === value) {

        // if you want the index or property "0", "1", "2"... etc.
        // item._index = key;

        return item._index = key; 
      }
      
 /*   return $.grep(object, function(element, index){
      
      if(element.comparisonKey === value){
        element.latestJSON = json;
        return element
      }
      */
    });
}

function switchAudio(url, currentTime, newAudioID){
  //console.log('switch audio');
  //console.log(newAudioID);
  //console.log(url);
  //console.log('Old time ' + currentTime);

  var audio = $('#'+comparisonKey+'track');
  audio.attr('src', url);
  var newTime = Number(everpolate.linear(currentTime, mat_startTimes[audioNum], mat_startTimes[newAudioID])[0]);
  
  audio.bind('loadedmetadata', function(){
    audio[0].currentTime = newTime.toFixed(4);
  });

audio.bind('canplay', function() {
   // console.log('New time '  + audio[0].currentTime);
   audio[0].play();
   audioNum = newAudioID;
   }); 
};

function createSourceButtons(comparisonKey){
  $.getJSON('../sources.json', function(data){
    sources = data;
    //console.log(data);
    sourcesLoaded = true
  }, 'json');
      
  if(sourcesLoaded !== true){
    setTimeout(function(){
      createSourceButtons(comparisonKey);
    },1000);
  }else{
    //console.log('processing sources for: ' +comparisonKey);
    $.each(sources.source, function(index, source){
      var label = source.label;
      $.each(source.movement, function(index, mov){
        if(mov.comparisonKey === comparisonKey){
          var btn = $('<button type="button" class="btn btn-small" id="'+mov.id+'">'+label+'</button>');
          $('#' + comparisonKey + ' .sourceList .btn-group-vertical').append(btn);
          
          $('#'+mov.id).click(function(event){
            var buttonID = event.currentTarget.id;
            $('.recordingList button').toggleClass('btn-primary', false);
            $('#' + buttonID).toggleClass('btn-primary', true);
            //loadMeasureCoreChart(source.id);
            //renderSource(mov.id);
            
          });
        }
      });
    }); 
  }
};

function appendMetadata(recording){
    
    $('#'+comparisonKey+'recordingMetadata').empty();
    
    var cover = $('<img id="cover" src="' + recording.coverURI + '" alt="cover" class="span12"/>');
    var buyLink = $('<a role="button" class="btn btn-sm buy" id="buyButton" href="'+recording.metadata.link+'" target="_blank">GET<span class="glyphicon glyphicon-shopping-cart"/></a>');//<a role="button" class="btn btn-sm buy" id="buyButton" href="'+recording.metadata.link+'" target="_blank">GET<span class="glyphicon glyphicon-shopping-cart"/></a>
    $('#buyButton').click(function(event){
        
    });
    $('#'+comparisonKey+'recordingMetadata').append(cover);
    $('#'+comparisonKey+'recordingMetadata').append(buyLink);
    
    
    //TODO Title als heading
    $('#'+comparisonKey+'recordingMetadata').append($('<h3>' + recording.metadata.title + '</h3>'));
    
    var list = $('<dl/>');
    console.log(recording);
    list.append($('<dt>Conductor</dt>'));
    list.append($('<dd>'+ recording.metadata.conductor +'</dd>'));
    list.append($('<dt>Ensemble</dt>'));
    list.append($('<dd>'+ recording.metadata.ensemble +'</dd>'));
    list.append($('<dt>Year</dt>'));
    list.append($('<dd>'+ recording.metadata.year +'</dd>'));
    list.append($('<dt>Cast</dt>'));
    list.append($('<dd>'+ recording.metadata.cast +'</dd>'));
    list.append($('<dt>Capture</dt>'));
    list.append($('<dd>'+ recording.metadata.capture +'</dd>'));
    list.append($('<dt>Format</dt>'));
    list.append($('<dd>'+ recording.metadata.format +'</dd>'));
    list.append($('<dt>Carrier</dt>'));
    list.append($('<dd>'+ recording.metadata.carrier +'</dd>'));
    list.append($('<dt>Label</dt>'));
    list.append($('<dd>'+ recording.metadata.label +'</dd>'));
    list.append($('<dt>Series</dt>'));
    list.append($('<dd>'+ recording.metadata.series +'</dd>'));
    list.append($('<dt>Catalog-Nr.</dt>'));
    list.append($('<dd>'+ recording.metadata.catalogNr +'</dd>'));
    list.append($('<dt>Copyright</dt>'));
    list.append($('<dd>'+ recording.metadata.copyright +'</dd>'));
    console.log(list);
    
    $('#'+comparisonKey+'recordingMetadata').append(list);
    $('#'+comparisonKey+'recordingMetadata').append('<div>'+recording.metadata.remark+'</div>');
    
    
}

function createRecordingButtons(comparisonKey){
  $.getJSON('../recordings.json', function(data){
    recordings = data;
    //console.log(data);
    recordingsLoaded = true
  }, 'json');
  
  if(recordingsLoaded !== true){
    setTimeout(function(){createRecordingButtons(comparisonKey);},1000);
  }else{
    //console.log('processing recordings for: ' +comparisonKey);
    $.each(recordings.recording, function(index, recording){
      var buttonLabel = recording.buttonLabel;
      //$.each(source.movement, function(index, mov){
      if(recording.comparisonKey === comparisonKey){
        var btn = $('<button type="button" class="btn btn-small" id="'+comparisonKey+recording.id+'">'+buttonLabel+' <span class="currentTime">00:00</span></button>');
        $('#' + comparisonKey + ' .recordingList .btn-group-vertical').append(btn);
        
        $('#'+comparisonKey+recording.id).click(function(event){
          var buttonID = event.currentTarget.id;
          $.getJSON(recording.annotsURI, function(data){
            console.log('load recording annots for '+recording.id);
            console.log(data);
            json = data;
          }, 'json');
          $('#'+comparisonKey+' .recordingList button').toggleClass('btn-primary', false);
          $('#'+comparisonKey+recording.id).toggleClass('btn-primary', true);
          //console.log(recording.audioURI, globalTime, recording.id);
          switchAudio(recording.audioURI, globalTime, recording.id); //Potential race problem
          audioNum = recording.id;
          appendMetadata(recording);
        });
      }
      //});
    }); 
  }
};

function renderSource(meiURI){
  console.log('renderSource supplied: ' + meiURI);
  //console.log('TODO: implement real source switch');
  /* Load the file using HTTP GET */
  
  if($('#'+comparisonKey+'output svg').length > 0){
    return
  } else {
  
    $.get( meiURI, function( data ) {
    var svg = vrvToolkit.renderData( data + "\n", JSON.stringify({
        inputFormat: 'mei',
        pageHeight: 2970,
        pageWidth: 2100,
        ignoreLayout: 1,
        border: 5,
        scale: 25 })
      );
    
      $('#'+comparisonKey+'output').html(svg);
      //console.log(vrvToolkit.getPageCount());
    });
  }
};

function updateAudioTimes(currentTime, source){
  
};

function getMusicSourceMeasureID(coreRef){

  
  
}

function prepareSync(comparisonKey){
    //console.log('prepareSync for: ' + comparisonKey);
    $.each(recordings.recording, function(index, recording){
   //   if(recording.comparisonKey === comparisonKey){
        $.getJSON(recording.annotsURI, function(data){
          var measureStarts = [];
          var measureLabels = [];
          $.each(data.measure, function(index, item){
            measureStarts.push(data.measure[index].start);
            measureLabels.push(item.label);
          });
          mat_startTimes[recording.id] = measureStarts;
          measures[recording.id] = measureLabels;
        }, 'json');
        
        $("#"+comparisonKey+"track").bind('timeupdate', function() {
          //console.log('updateTime for ' + recording.id);
          //console.log(recording.id);
          var time = this.currentTime;
          //console.log(time);
          globalTime = time;
          //console.log(globalTime);
          var warpedTime = Number(everpolate.linear(time, mat_startTimes[audioNum], mat_startTimes[recording.id])[0]);
          //console.log(warpedTime);
          var mmss = new Date(null, null, null, null, null, warpedTime).toString("mm:ss")
          $("#" + comparisonKey + recording.id + " .currentTime").text(mmss);

        });

     //}
   });   
}

/**
 * get image URI, measure number, measure ID from JSON based on input time
 * @param      {Number}   time from audio player
 * @var        {Number}   bestDiff
 */
function getMeasure(time){
  console.log('getMeasure for time: ' + time);
  //var bestDiff = 0;
  //var minDiff;
  //var i;
  //var cur;

  var imageUri;
  var measureID;
  //var measureNumber;
  var measureCount;
  var measureIndex;
  
  // Compute exact measure position by interpolation
  measurePosition = Number(everpolate.linear(time, mat_startTimes[audioNum], measures[audioNum])[0]);
  // Compute measure number (measureCount)
  measureCount    = Math.floor( measurePosition );
  measureIndex    = measureCount-1;
  if(measureIndex >= 0){
    imageUri = json.measure[measureIndex].facsURI;
    checkImage(imageUri, comparisonKey);
    console.log(imageUri);
    coordinates = json.measure[measureIndex].coordinates;
    console.log(coordinates);
    highlightImageArea(coordinates);
    measureID = json.measure[measureIndex].sourceIdRef;  
  }
  else{
    measureIndex = 0;
  };
  //set facsimile text field to new value
  $('#facsimileID').text(imageUri);
  //set measure count to new value
  $("#measureCount").text(measureCount);
  //set measure position to new value
  $("#measurePosition").text(measurePosition.toFixed(3));
  //set measure ID to new value
  $("#measureID").text(measureID);
  console.log('getMeasure count: '+ measureCount);
  console.log('getMeasure returns: ' + measureID);
  return measureID;
};

function highlightImageArea(coordinates, widht, height){
    currentWidth = $(comparisonKey+'currentImage').width();
    currentHeight = $(comparisonKey+'currentImage').height();
    
    factor = 0.5;//currentWidth/width;
    
    ulx = coordinates.ulx * factor;
    uly = coordinates.uly * factor;
    lrx = coordinates.lrx * factor;
    lry = coordinates.lry * factor;
    
};

 /**
 * check if submitted image URI equals current image URI
 * @param      {String}   imageURI image URI from JSON to be checked against currently visible images URI
 */
function checkImage(imageUri, comparisonKey) {
  if (currentImageUri !== imageUri){
    setImage(imageUri, comparisonKey+'currentImage', offline);
  }
};

 /**
 * set an img elements src attribute to supplied URI
 * @param      {String}   imageUri new image URI
 * @param      {String}   targetID ID of the target img element
 */
function setImage(imageUri, targetID, local){
  console.log('setImage in '+targetID);
  currentImageUri = imageUri;
  if(local){
    document.getElementById(targetID).src = imageUri;
  } else {
    document.getElementById(targetID).src = 'http://freischuetz-digital.de/digilib/Scaler/freidi/'+imageUri+'?dw=710&amp;mo=fit';
  }
  
};


/*
 * research
 */
/*var mediaElement = document.getElementById('track');
mediaElement.seekable.start();  // Returns the starting time (in seconds)
mediaElement.seekable.end();    // Returns the ending time (in seconds)
mediaElement.currentTime = 122; // Seek to 122 seconds
mediaElement.played.end();      // Returns the number of seconds the browser has played*/