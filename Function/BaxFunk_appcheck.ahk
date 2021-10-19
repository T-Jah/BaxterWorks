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
	
	If !FindProc("BaxterWorks.exe")
        Run, %Bax_Start%\BaxterWorks.exe
	ExitApp
}

FindProc(p) {
   Process, Exist, % p
   Return, ErrorLevel
}



BaxFunk_toolstart(){
global

		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %Bax_Start%

		IniRead, Radio1, %userini%, Komponenten, Radio1 , 0
		If (Radio1 = 0){
		;MsgBox, keine App im Autostart
		return
		}
		else If (Radio1 = 1){
		IniRead, Check1, %userini%, Komponenten, Check1 , 0
		IniRead, Check2, %userini%, Komponenten, Check2 , 0
		IniRead, Check3, %userini%, Komponenten, Check3 , 0
		IniRead, Check4, %userini%, Komponenten, Check4 , 0
		IniRead, Check5, %userini%, Komponenten, Check5 , 0
		IniRead, Check6, %userini%, Komponenten, Check6 , 0
		}
		if (Check1 = 1)
		{
		run, %Bax_Start%\Apps\Emoji\EmojiMenu.exe
		}
		If (Check2 = 1)
		{
        	run, %Bax_Start%\Apps\FavFolder\FavoriteFolders.exe
		}
		If (Check3 = 1)
		{
		run, %Bax_Start%\Apps\MiniDB\MiniDBs.exe
		}
		If (Check4 = 1)
		{
		run, %Bax_Start%\Apps\NumpadZeichner\NumpadZeichner.exe
		}
		If (Check5 = 1)
		{
		run, %Bax_Start%\Apps\DesktopPainter\DesktopPainter.exe
		}
		If (Check6 = 1)
		{
		run, %Bax_Start%\Apps\SuchBax\SuchBax.exe
		}
	}
