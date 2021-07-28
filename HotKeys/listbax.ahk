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

:*:.list::	
SendInput {Raw}
(

┌───────────────────────────────────────────────────────────────────────────────────────────────────────┐  
│                                 Liste der Auslöser und Hotkeys					│  
│ ===================================================================================================== │  
│ TBKeys		...............; STRG + 2        Benutzervariable Bax_Flex startet eine App     │  
│ Fenster LaunchBax 	...............; STRG + 3        oder Webseite mit STRG+Shift+0 (Null)	        │  
│ SuchBax	        ...............; STRG + 5                 				        │  
│ DesktopPainter	...............; STRG + 7                 				        │  
│ EmojiMenu (STRG+Alt+e) ..............; STRG + 9 			                                │  
│ AHK-Handbuch		...............; STRG + 0 	 						│  
│ IPfindMap  		...............; STRG + i							│  
│ Umlaute (html)	...............; STRG + ä,ö,ü,ß,Ä,Ö,Ü						│  
├───────────────────────────────────────────────────┬───────────────────────────────────────────────────┤  
│ Panikbutton		.........; STRG + WIN + P   │  							│  
│ Toggle alle Hotkeys	.........; STRG + WIN + T   │ NumpadZeichner	.............; STRG + Shift + 1 │  
│ FavFolders		.........; STRG + Shift + f │ NumpadZeichner	.............; STRG + Shift + 1 │  
│ IP Info		.........; STRG + Shift + i │   						│  
│ KillerBax		.........; STRG + Shift + k │ CaptureBax	.............; STRG + Shift + 3 │  
│ LiveWindow	 	.........; STRG + Shift + l │ MagnifyBax	.............; STRG + Shift + 4 │
│ Fenster MiniDBs 	.........; STRG + Shift + m │ Toggle FensterInfo.............; STRG + Shift + 8 │  
│ notepad / 2Win        .........; STRG + Shift + n │                                                   │  
│ Always on top		.........; STRG + Shift + o │ Bax_Flex App	.............; STRG + Shift + 0 │   
│ Reload all		.........; STRG + Shift + r │                                                   │  
│ Uhr, digital		.........; STRG + Shift + u │                                                   │  
│ VarSchau		.........; STRG + Shift + v │ iSafeText 	.............; STRG + ALT + b   │  
├───────────────────────────────────────────────────────────────────────────────────────────────────────┤  
│ Textmarkierung in GROSSBUCHSTABEN	; Alt GR + i                                                    │  
│ Textmarkierung in kleinbuchstaben	; Alt GR + o                                                    │  
│ Anfangsbuchstabe Groß 		; Alt GR + p                                                    │  
│ aktuelles Datum 		        ; STRG + Win + F1 (.heute)                                      │  
│ aktuelle Uhrzeit			; STRG + Win + F2 (.jetzt)                                      │  
│ Datumsrechner				; STRG + Win + F3 (.dann)                                       │  
│ Text einrahmen </b>			; STRG + b                                                      │  
│ - mit []				; STRG + Shift + b                                              │  
│ - <a href html link			; STRG + Win + b                                                │  
│ Ton an/aus				; STRG + Punkt                                                  │  
├───────────────────────────────────────────────────────────────────────────────────────────────────────┤  
│ MD-Module: 		 md_software _tab _todo _umleit                                                 │  
│ AHK Textbausteine:	 ahk_box1 bis_4 _break _1end _end _1head _head _icon _info _index _kasten1      │  
│ 			 _tabelle1+2 _options                                                           │  
│ TXT Bausteine: 	 txt_box1 bis_3 _port _pubbw _bw _tabelle1+2 _tb _todo                          │  
└───────────────────────────────────────────────────────────────────────────────────────────────────────┘  
 
)
return

