;------------------------------------------------------------------------------------->
; AHK AutoHotKey Skript. Handbuch und HP: https://ahkde.github.io/
; (c) 2021 T-Jah Tom
; https://github.com/T-Jah					   07/2021 Version 009
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

:*:.listbax::	
SendInput {Raw}
(
┌───────────────────────────────────────────────────────────────────────────────────────────────────────┐  
│                                 Liste der Auslöser und Hotkeys Version 020				│  
│ ===================================================================================================== │  
│ Diese Liste anzeigen	...............; STRG + 1        Benutzervariable Bax_Flex startet eine App     │  
│ TBKeys		...............; STRG + 2        oder Webseite mit STRG+Shift+0 (Null)	        │  
│ SuchBax	        ...............; STRG + 5                 				        │  
│ AHK-Handbuch		...............; STRG + 0 	 						│  
│ IPfindMap  		...............; STRG + i							│  
│ Umlaute (html)	...............; STRG + ä,ö,ü,ß,Ä,Ö,Ü						│  
├───────────────────────────────────────────────────┬───────────────────────────────────────────────────┤  
│ DesktopPainter	.........; STRG + Shift + d │ Panikbutton	.............; STRG + WIN + P   │  
│ EmojiMenu		.........; STRG + Shift + e │ Toggle alle Hotkey ............; STRG + WIN + T   │  
│ FavFolders		.........; STRG + Shift + f │ GetReadyBax	.............; STRG + Shift + 1 │  
│ IP Info		.........; STRG + Shift + i │ NumpadZeichner	.............; STRG + Shift + 2	│  
│ KillerBax		.........; STRG + Shift + k │ CaptureBax	.............; STRG + Shift + 3 │  
│ LiveWindow	 	.........; STRG + Shift + l │ IconExtractor	.............; STRG + Shift + 4 │  
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
│ MD-Module: 	      	 md_software _tab _todo _umleit                                          	│  
│ AHK Textbausteine: 	 ahk_box1-4 _break _end _head _icon _info _msg _options _tabelle1+2 _titel      │  
│ TXT Bausteine:     	 txt_box1 bis_3 _port _pubbw _bw _tabelle1+2 _tb _todo                   	│  
└───────────────────────────────────────────────────────────────────────────────────────────────────────┘  
 
)
return

