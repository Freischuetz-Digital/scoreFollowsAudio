(: FreiDi-scoreFollowsAudio
 : Copyright Benjamin W. Bohl 2014.
 : bohl(at)edirom.de
 :
 : http://www.github.com/edirom/ediromSourceManager
 : 
 : ## Description & License
 : 
 : This file creates a JSON file for FreiDi-scorefollowsAudio from MEI
 :
 : This program is free software: you can redistribute it and/or modify
 : it under the terms of the GNU General Public License as published by
 : the Free Software Foundation, either version 3 of the License, or
 : (at your option) any later version.
 :
 : This program is distributed in the hope that it will be useful,
 : but WITHOUT ANY WARRANTY; without even the implied warranty of
 : MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 : GNU General Public License for more details.
 :
 : You should have received a copy of the GNU General Public License
 : along with this program.  If not, see <http://www.gnu.org/licenses/>.
 :)
 
xquery version "1.0";

declare namespace mei="http://www.music-encoding.org/ns/mei";
declare namespace json="http://www.json.org";

(:import module namespace xqjson="http://xqilla.sourceforge.net/lib/xqjson";:)


(:declare option exist:serialize "method=text media-type=text/plain";:)

declare option exist:serialize "method=json media-type=text/javascript";

declare variable $musicSource := doc('file:///C:\Users\bwb\Documents\GitHub\FreiDi\scoreFollowWebDemo\data\freidi-musicSource_A.xml');
(:declare variable $clips2json := for $avFile in //avFile return :)
declare variable $recording := doc('file:///C:\Users\bwb\Documents\GitHub\FreiDi\scoreFollowWebDemo\data\xslt\recordingPrep\mei\Weber_Freischuetz-09_KleiberErich1955_annoMeasures.txt_mei.xml');
declare variable $resultFileName := concat(substring-before(tokenize(document-uri($recording),'\\')[last()],'.txt'),'.json');
(:xqjson:serialize-json(<json type="array">{$clips2json}</json>):)

element json {
  for $clip in $recording//mei:clip
  let $measureId := substring-after($clip/@startid,'#')
  let $coreIdRef := substring-after($recording//mei:measure[@xml:id =$measureId]/@sameas,'core.xml')
  let $measure.musicSource := $musicSource//mei:measure[@sameas = concat('../core.xml',$coreIdRef)]
  let $zoneId := substring-after($measure.musicSource/@facs,'#')
  let $zone := $musicSource//mei:zone[@xml:id = $zoneId] (:id(substring-after($measure.musicSource/@facs,'#')):)
  return
    element measure {
      element recordingIdRef {string($clip/@startid)},
      element coreIdRef {$coreIdRef},
      element sourceIdRef {concat('#',$measure.musicSource/@xml:id)},

      element start {
        attribute json:literal {},
        number($clip/@begin)
      },
      element end {
        attribute json:literal {},
        number($clip/@end)
      },
      element label {
        attribute json:literal {},
        substring-after($clip/@startid,'_measure')
      },
      element facsURI {string($zone/parent::mei:surface/mei:graphic/@target)},
      element coordinates {
        for $att in $zone/@*[local-name()=('ulx','uly','lrx','lry')]
        return $att
      }
    }
}

