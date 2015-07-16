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

(:import module namespace xqjson="http://xqilla.sourceforge.net/lib/xqjson";:)


(:declare option exist:serialize "method=text media-type=text/plain";:)

declare option exist:serialize "method=json media-type=text/javascript";

declare variable $musicSource := doc('data/freidi-musicSource_A.xml');
(:declare variable $clips2json := for $avFile in //avFile return :)
declare variable $recording := doc('data/Weber_Freischuetz-06_Bloemeke2013_annoMeasures.txt_mei.xml');
(:xqjson:serialize-json(<json type="array">{$clips2json}</json>):)

element json {
  for $clip in $recording//mei:clip
  let $coreIdRef := substring-after($recording//id(substring-after($clip/@startid,'#'))/@sameas,'core.xml')
  let $measure.musicSource := $musicSource//mei:measure[@sameas = concat('../core.xml',$coreIdRef)]
  let $zone := $musicSource//id(substring-after($measure.musicSource/@facs,'#'))
  return
    element measure {
      element recordingIdRef {string($clip/@startid)},
      element coreIdRef {$coreIdRef},
      element sourceIdRef {concat('#',$measure.musicSource/@xml:id)},

      element start {number($clip/@begin)},
      element end {number($clip/@end)},
      element label {substring-after($clip/@startid,'_measure')},
      element facsURI {string($zone/parent::mei:surface/mei:graphic/@target)},
      element coordinates {
        for $att in $zone/@*[local-name()=('ulx','uly','lrx','lry')]
        return $att
      }
    }
}

