<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:mei="http://www.music-encoding.org/ns/mei"
    exclude-result-prefixes="xs xd"
    version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Aug 11, 2014</xd:p>
            <xd:p><xd:b>Author:</xd:b> Johannes Kepper</xd:p>
            <xd:p>This stylesheet takes a file from Thomas and generates MEI from it. The file should look like so:
            
                 1.915291666,1
                 3.766854166,2
                 5.435979166,3
                 7.028479166,4
                 8.720645833,5
                 10.345645833,6
                 12.044604166,7
                 13.729145833,8
                 15.428437500,9
                 17.066520833,10
                 18.720979166,11
                 20.657791666,12
                 22.334458333,13
                 23.996854166,14
            
            The stylesheet also considers the filename for metadata. 
            
            </xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output method="xml" indent="yes"/>
  
    <xd:doc scope="component">
      <xd:desc>path to input file</xd:desc>
    </xd:doc>
  <xsl:param name="input"  select="('recordingPrep/annotations/Weber_Freischuetz-06_Ackermann1951_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Bloemeke2013_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Boehm1972_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_BruecknerRueggeberg1957_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Davis1990_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Elmendorff1944_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Furtwaengler1954_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Gui1955_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Harnoncourt1995_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Hauschild1985_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Heger1969_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Hollreiser1956_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Janowski1994_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Jochum1960_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Keilberth1958_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_KleiberCarlos1973_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_KleiberErich1955_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Kubelik1979_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Leopold1972_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Matacic1967_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_MuellerKray1950_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Orlov1946_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Penin1998_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Rossi1956_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Sawallisch1972_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-06_Weil2001_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Ackermann1951_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Bloemeke2013_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Boehm1972_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_BruecknerRueggeberg1957_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Davis1990_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Elmendorff1944_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Furtwaengler1954_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Gui1955_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Harnoncourt1995_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Hauschild1985_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Heger1969_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Hollreiser1956_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Janowski1994_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Jochum1960_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Keilberth1958_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_KleiberCarlos1973_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_KleiberErich1955_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Knappertsbusch1939_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Krips1933_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Kubelik1979_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Leopold1972_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Matacic1967_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_MuellerKray1950_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Orlov1946_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Penin1998_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Rossi1956_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Sawallisch1972_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Schmid1994_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-08_Weil2001_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Ackermann1951_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Bloemeke2013_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Boehm1972_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_BruecknerRueggeberg1957_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Davis1990_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Elmendorff1944_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Furtwaengler1954_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Gui1955_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Harnoncourt1995_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Hauschild1985_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Heger1969_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Hollreiser1956_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Janowski1994_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Jochum1960_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Keilberth1958_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_KleiberCarlos1973_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_KleiberErich1955_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Kubelik1979_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Leopold1972_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Matacic1967_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_MuellerKray1950_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Orlov1946_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Penin1998_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Sawallisch1972_annoMeasures.txt', 'recordingPrep/annotations/Weber_Freischuetz-09_Weil2001_annoMeasures.txt')"></xsl:param>
    
    <xsl:template match="/">
        <!--<xsl:variable name="fileName" select="tokenize(document-uri(root()),'/')[last()]" as="xs:string"/>-->
      <xsl:for-each select="for $i in $input return $i">
          <xsl:message select="."></xsl:message>
            <xsl:variable name="fileName" select="tokenize(.,'/')[last()]" as="xs:string"/>
            <xsl:variable name="targetPath" select="substring-before(.,concat('/',$fileName))" as="xs:string"/>
            
            <xsl:variable name="prepFile">
                <tmp>
                    
                    <xsl:for-each select="tokenize( unparsed-text(., 'utf-8'),'\n')">
                        <xsl:if test="string-length(.) gt 0">
                          <line measure="{tokenize(.,',')[3]}" clipStart="{tokenize(.,',')[1]}" clipEnd="{tokenize(.,',')[2]}"/>    
                        </xsl:if>
                    </xsl:for-each>
                </tmp>
            </xsl:variable>
            
            <xsl:message select="$fileName"/>
            
            <xsl:if test="count(tokenize($fileName,'_')) lt 3">
                <xsl:message terminate="yes">Der Dateiname entspricht nicht den Erwartungen ["Komponist_Werk_Aufnahme(_etc)?"]. Die Schuld daran trägt Thomas…</xsl:message>    
            </xsl:if>
            
            <xsl:variable name="fileComp" select="tokenize($fileName,'_')[1]" as="xs:string"/>
            <xsl:variable name="fileWork" select="tokenize($fileName,'_')[2]" as="xs:string"/>
            <xsl:variable name="workTitle" select="tokenize($fileWork,'-')[1]" as="xs:string"/>
            <xsl:variable name="moveNo" select="tokenize($fileWork,'-')[2]" as="xs:string"/>
            <xsl:variable name="fileRecording" select="tokenize($fileName,'_')[3]" as="xs:string"/>
            
            <xsl:result-document href="{$targetPath}/../mei/{$fileName}_mei.xml">
                
              <mei meiversion="2013" xmlns="http://www.music-encoding.org/ns/mei">
                    <meiHead>
                        <fileDesc>
                            <titleStmt>
                              <title><xsl:value-of select="$fileRecording"/></title>
                                <!--<respStmt>
                                    <persName role="cmp"><xsl:value-of select="$fileComp"/></persName>
                                </respStmt>-->
                            </titleStmt>
                            <pubStmt/> 
                            <sourceDesc>
                                <source xml:id="{$fileRecording}">
                                    <titleStmt>
                                        <title><xsl:value-of select="$fileRecording"/></title>
                                    </titleStmt>
                                </source>
                            </sourceDesc>
                        </fileDesc>
                        <revisionDesc>
                            <change n="1">
                                <respStmt>
                                    <persName nymref="#smTP"/>
                                </respStmt>
                                <changeDesc>
                                    <p>Measure onsets identified and stored as plain text file.</p>
                                </changeDesc>
                                <date notafter="{substring(string(current-date()),1,10)}"/>
                            </change>
                            <change n="2">
                                <respStmt>
                                    <persName nymref="#smBWB"/>
                                </respStmt>
                                <changeDesc>
                                    <p>Plain file converted to MEI using audioClips2mei.xsl.</p>
                                </changeDesc>
                                <date isodate="{substring(string(current-date()),1,10)}"/>
                            </change>
                        </revisionDesc>
                    </meiHead>
                    <music>
                        <performance>
                            <recording decls="#{$fileRecording}">
                                <avFile target="{substring-before($fileName,'_annoMeasures.txt')}.mp3">
                                    <xsl:for-each select="$prepFile//line">
                                        <xsl:variable name="pos" select="position()" as="xs:integer"/>
                                        
                                        <clip begin="{@clipStart}" end="{@clipEnd}" betype="time">
                                            <xsl:choose>
                                                <xsl:when test="contains(@measure,'.')">
                                                    <xsl:attribute name="type" select="'beat'"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:attribute name="startid" select="concat('#',$fileRecording,'_mov',replace($moveNo,'0',''),'_measure',@measure)"/>
                                                    <xsl:attribute name="type" select="'measure'"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                            
                                        </clip>
                                    </xsl:for-each>
                                </avFile>
                            </recording>
                        </performance>
                        <body>
                            <mdiv xml:id="{concat($fileRecording,'_mov',replace($moveNo,'0',''))}">
                                <score>
                                    <section>
                                        <xsl:for-each select="$prepFile//line">
                                            <xsl:variable name="pos" select="position()" as="xs:integer"/>
                                            
                                            <measure xml:id="{concat($fileRecording,'_mov',replace($moveNo,'0',''),'_measure',@measure)}" sameas="{concat('../core.xml#core_mov',replace($moveNo,'0',''),'_measure',@measure)}"/>
                                        </xsl:for-each>
                                    </section>
                                </score>
                            </mdiv>
                        </body>
                    </music>
                </mei>
                
            </xsl:result-document>
        </xsl:for-each>
        
        
    </xsl:template>
    
</xsl:stylesheet>