;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxterWorks Software | T-Jah Tom | Funktionen | Aufruf mit: Bax_FensterInfo_Create()   	               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;     Version 003

Bax_FensterInfo_Create(){
	global
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %Bax_Start%
		FileEncoding UTF-8
		#SingleInstance force

		#Persistent
		SetTimer, FolgeCursor, 500
	

}

FolgeCursor:
MouseGetPos, , , id, control
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
ControlGetFocus, ActiveWin, A
ToolTip, Unique ID: ahk_id %id%`nTitel: %title%`nClass: ahk_class %class%`nControl: %control%`nActive Control: %ActiveWin%`n`nAN und AUS mit STRG+Shift+8`nSTRG+Shift+c um Infos in den Arbeitsspeicher zu kopieren
return
			; STRG Shift 8
^+8:: 
SetTimer, FolgeCursor, % (Toggle:=!Toggle) ? "Off" : "On"
If Toggle
 ToolTip

Return
			; STRG Shift c

^+c::ClipBoard := "Unique ID: ahk_id " . id . Chr(13) . Chr(10) . "Titel: " . title . Chr(13) . Chr(10) . "Class: ahk_class" .  class . Chr(13) . Chr(10) . "Control: " . control . Chr(13) . Chr(10) . "Active Control: " . ActiveWin


