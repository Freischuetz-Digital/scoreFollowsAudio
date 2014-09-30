xquery version "1.0";

declare namespace mei="http://www.music-encoding.org/ns/mei";

import module namespace xqjson="http://xqilla.sourceforge.net/lib/xqjson";


(:declare option exist:serialize "method=text media-type=text/plain";:)

declare option exist:serialize "method=json media-type=text/javascript";

declare variable $Autograph := doc('file:///C:\Users\bwb\Desktop\temp\SVN_FreiDi\musicSources\sourcePrep\06 Music included\A.xml');
(:declare variable $clips2json := for $avFile in //avFile return :)

(:xqjson:serialize-json(<json type="array">{$clips2json}</json>):)

element json {
  for $clip in doc('file:///C:\Users\bwb\Documents\GitHub\FreiDi\scoreFollowWebDemo\Weber_Freischuetz-06_FreiDi_annoMeasures.xml')//clip
  let $zone := $Autograph//mei:zone[string(@data) = concat('#A',substring-after($clip/@startid,'FreiDi'))]
  return
    element measures {
      element timestamp {string($clip/@begin)},
      element measure {substring-after($clip/@startid,'_measure')},
      element measureID {substring-after($zone/@data,'#')},
      element page {string($zone/parent::mei:surface/mei:graphic/@target)},
      element coordinates {
        for $att in $zone/@*[local-name()=('ulx','uly','lrx','lry')]
        return $att
      }
    }
}

