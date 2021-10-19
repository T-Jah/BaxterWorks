;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxterWorks Software | T-Jah Tom | Funktionen | Aufruf mit: Bax_2Win_start() 	   	               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;     Version 009

Bax_2Win_start(){
global
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %A_ScriptDir%
		FileEncoding UTF-8
		#SingleInstance ignore
;Testbox
; MsgBox %DeinOrdner1%
; in der Haupt.ini
; -- Pfade zu den zu öffnenden Fenstern festlegen (kann beliebig geändert werden)
IniRead, DeinOrdner1, %userini%, UserVars, DeinOrdner1, %A_Space% 
IniRead, DeinOrdner2, %userini%, UserVars, DeinOrdner2, %A_Space% 


fenster_links = %DeinOrdner1%
fenster_rechts = %DeinOrdner2%


;-- Monitorgrösse bestimmen

SysGet, Mon1, Monitor, 1

fenster_links_hoehe := (Mon1Bottom - 100)
fenster_rechts_start_x := (Mon1Right / 2)
fenster_rechts_hoehe := (Mon1Bottom - 100)


; -- Variablen festlegen --

SetTitleMatchMode, 2


fenster_links_x = 0
fenster_links_y = 80
fenster_links_breite = %fenster_rechts_start_x%
fenster_links_hoehe = %fenster_links_hoehe%

fenster_rechts_x = %fenster_rechts_start_x%
fenster_rechts_y = 80
fenster_rechts_breite = %fenster_rechts_start_x%
fenster_rechts_hoehe = %fenster_rechts_hoehe%

; -- Variablen berechnen --

StringLen, pfadlaenge_fenster_links, fenster_links
StringLen, pfadlaenge_fenster_rechts, fenster_rechts

laenge_fenster_name_links := pfadlaenge_fenster_links - 3
laenge_fenster_name_rechts := pfadlaenge_fenster_rechts - 3

StringRight, fenster_name_links, fenster_links, laenge_fenster_name_links
StringRight, fenster_name_rechts, fenster_rechts, laenge_fenster_name_rechts



; -- Fenster links anzeigen

Run, %fenster_links%
Sleep 1000
WinMove, %fenster_name_links%, , %fenster_links_x%, %fenster_links_y%, %fenster_links_breite%, %fenster_links_hoehe%
;WinMove, FensterTitel, FensterText, X, Y , Breite, Höhe, IgnoriereTitel, IgnoriereText


; -- Fenster rechts anzeigen

Run, %fenster_rechts%
Sleep 1000
WinMove, %fenster_name_rechts%, , %fenster_rechts_x%, %fenster_rechts_y%, %fenster_rechts_breite%, %fenster_rechts_hoehe%

; -- Notepad öffnen und zentrieren

Run, %A_WinDir%\notepad.exe
WinWait, Unbenannt - Editor,, 3
if ErrorLevel
{
    MsgBox, WinWait hat das Zeitlimit überschritten.
    return
}
else
    	WinGetPos, X, Y, W, H
	WinMove, Unbenannt - Editor, , 0, 100, 400, 800
;	WinSet, TransColor, white, Unbenannt - Editor 	; macht weiß unsichtbar
;	WinSet, Region,, ahk_class Notepad 		; macht alle Region Befehle weg
;	WinSet, Transparent, Off, Unbenannt - Editor		; setzt Transparenz auf 0
	WinSetTitle, BaxterWorks Notizfenster			; Titel verschwindet wieder
	WinSet, AlwaysOnTop, On
SendInput {Raw}
(
## Todo-Liste

<!-- Version 002 --> 

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


}


