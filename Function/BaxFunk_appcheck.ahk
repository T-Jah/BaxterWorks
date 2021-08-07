;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxterWorks Software | T-Jah Tom | Funktionen | Aufruf mit: BaxFunk_appststart() 	   	               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;     Version 001


BaxFunk_appststart(){
global
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %Bax_Start%
	
	if !WinExist("ahk_exe BWAppBar.exe")
	;MsgBox, AppBar ist nicht an %Bax_Start%
	Run, %Bax_Start%\Apps\BWAppBar\BWAppBar.exe

}