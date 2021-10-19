;------------------------------------------------------------------------------------->
; AHK AutoHotKey Skript. Handbuch und HP: https://ahkde.github.io/
; (c) 2021 T-Jah Tom
; https://github.com/T-Jah					   05/2021 Version 008
;------------------------------------------------------------------------------------->
; Skript besteht überwiegend aus Schnippseln aus dem Handbuch und der Community.
;
; BaxterWorks Software:	http://www.baxterworks.de/software
;			http://blog.baxterworks.de
;                       ^ STRG + Shift ! Alt # WIN
;------------------------------------------------------------------------------------->
; More:    ......https://github.com/T-Jah
; Titel:   ......Name
; Licence: ......BaxterWorks Software is licensed under the MIT Licence

; Script options
#SingleInstance force 			; oder off
#NoEnv
SetWorkingDir %A_ScriptDir%		; wichtig
SendMode Input




; # MD Vorlagen --------------------------------------------------------------------->
 
 
:*:md_hilfe::
SendInput {Raw}
(
    Software: Hilfe/App/AppName
<!-- Version 001 -->
<!-- md2htm, aktiv in BaxterWorks Software-->

## BaxterWorks Software
###### zurück zur [Startseite](http://www.baxterworks.de/software)   

## AppName
Text

[![Logo](http://www.baxterworks.de/software/pix/tjah_banner_tr_600.png)](http://www.baxterworks.de/software/hilfe/help.htm) 


        Tags: ahk,hilfe,prozesse,taskmanager


(c) 1999 - 2021 T-Jah Tom, [BaxterWorks](http://www.baxterworks.de). [GitHub](https://github.com/T-Jah), [Blog](http://blog.baxterworks.de).  <p>
[![Logo](http://www.baxterworks.de/software/pix/bw_banner.png)](http://www.baxterworks.de/software/pix/bw_banner.png) 
<IMG SRC="https://www.tombesch.de/cgi-bin/location.cgi?seite=2021_bwsoftware_appname">

)
return

;-------------------------------------------------------------------------
 
:*:md_software::
SendInput {Raw}
(
##BaxterWorks Software
###Datei: .zip
     Kategorie: HotKeys, Textersetzung

<!-- Version 001 -->

|      Key   	 |     Value   	          |  
|:---------------|:-----------------------|  
|  **Autor**:	 | T-Jah Tom 		  |  
|  **Webseite**: | [BaxterWorks Software](http://www.baxterworks.de/software) |  
|  **Credits**:  | [Die offizielle Anleitung](https://ahkde.github.io/docs)   |  
| **Download**:  | [Zip-File](http://www.baxterworks.de/software/files/name.zip) mit .ahk und .exe	|  
  

###Inhalt:

Wenn dieses kleine Skript läuft, stehen dir 2 Hotkeys und 2 Textersetzungen zur Verfügung:  

- *STRG+WIN+F1*: fügt das aktuelle Datum ein, Format: 
- *STRG+WIN+F2*: die aktuelle Uhrzeit im Format 18 Uhr 48  
  
die gleichen Ergebnisse kannst mit den Textersetzungen erzielen. Auslöser sind (mit Punkt vorn):  

- *.heute*  
- *.jetzt*  
  

© 2021 [BaxterWorks Software](http://www.baxterworks.de/software), [T-Jah Tom](https://www.tombesch.de)  

[![Logo](https://www.tombesch.de/md/100/2020_tom_cap_100.png)](https://www.tombesch.de/md/png/2020_tom_cap_1000.png)  
  
)
return

;-------------------------------------------------------------------------

 
:*:md_tab::
SendInput {Raw}
(

md_tab

Todo-Liste
=============

| Status      | Frist       | Prio  | Aufgabe            |
|:------------|:-----------:|:-----:|:-------------------|
|  _ | _  | _  |  _ | 
|  _ | _  | _  |  _ |  
 

- [ ] 

(c) 2021 [T-Jah Tom](https://www.tombesch.de), [BaxterWorks](http://blog.baxterworks.de)  <p>
[![Logo](https://www.tombesch.de/md/100/2020_tom_cap_100.png)](https://www.tombesch.de/md/png/2020_tom_cap_1000.png) 
 
)

return



 
:*:md_umleit::
SendInput {Raw}
(
Verteilung per Skript
----------------------
Die Inhalte in diesem Ordner werden automatisch verteilt. Folgendes Skript wird genutzt:
 
<b>Skript</b>: 002_Updater


(c) 1999-2021 [T-Jah Tom](https://www.tombesch.de) - [BaxterWorks](http://www.baxterworks.de)
 
)
return


 
:*:md_todo::
SendInput {Raw}
(
## Todo-Liste

<!-- Version 001 --> 

### was   
- genau   
 [ ] Text  
 [ ]

### was noch
- genau   
 [ ] Text   
 [ ]   


      Tags: ToDo,Ticket,Jobs,Aufgabe

© 2021 [T-Jah Tom](https://www.tombesch.de), [BaxterWorks](http://www.baxterworks.de)

)
return


;--------------------------------------------------;
 
:*:md_knowledge::
SendInput {Raw}
(
```

██╗  ██╗███╗   ██╗ ██████╗ ██╗    ██╗██╗     ███████╗██████╗  ██████╗ ███████╗
██║ ██╔╝████╗  ██║██╔═══██╗██║    ██║██║     ██╔════╝██╔══██╗██╔════╝ ██╔════╝
█████╔╝ ██╔██╗ ██║██║   ██║██║ █╗ ██║██║     █████╗  ██║  ██║██║  ███╗█████╗  
██╔═██╗ ██║╚██╗██║██║   ██║██║███╗██║██║     ██╔══╝  ██║  ██║██║   ██║██╔══╝  
██║  ██╗██║ ╚████║╚██████╔╝╚███╔███╔╝███████╗███████╗██████╔╝╚██████╔╝███████╗
╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚══╝╚══╝ ╚══════╝╚══════╝╚═════╝  ╚═════╝ ╚══════╝
                                                                     
```

)
return
;--------------------------------------------------;
 
:*:md_tjah::
SendInput {Raw}
(
```

████████╗        ██╗ █████╗ ██╗  ██╗    ████████╗ ██████╗ ███╗   ███╗
╚══██╔══╝        ██║██╔══██╗██║  ██║    ╚══██╔══╝██╔═══██╗████╗ ████║
   ██║█████╗     ██║███████║███████║       ██║   ██║   ██║██╔████╔██║
   ██║╚════╝██   ██║██╔══██║██╔══██║       ██║   ██║   ██║██║╚██╔╝██║
   ██║      ╚█████╔╝██║  ██║██║  ██║       ██║   ╚██████╔╝██║ ╚═╝ ██║
   ╚═╝       ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝       ╚═╝    ╚═════╝ ╚═╝     ╚═╝
                                                                     
```

)
return
