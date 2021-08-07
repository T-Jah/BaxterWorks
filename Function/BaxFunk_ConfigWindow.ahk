;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxterWorks Software | T-Jah Tom | Funktionen | Aufruf mit: Bax_ConfigGui_Create()   	               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;     Version 010


Bax_ConfigGui_Create(){
global
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %Bax_Start%
		FileEncoding UTF-8
		#SingleInstance ignore

;MsgBox, %A_ScriptDir%
		GoSub,Bax_IniRead

If !(FileExist(File1) && FileExist(File2))
{
	UrlDownloadToFile, http://www.baxterworks.de/software/pix/bw_banner.png,  Grafix\bw_banner.png
	UrlDownloadToFile, http://www.baxterworks.de/software/pix/bw_software2.png,  Grafix\bw_software2.png
}
;---------------------------------------------------------------->
; Nach dem GoSub geht es hier weiter
;---------------------------------------------------------------->

;MsgBox, %A_ScriptDir%`n%A_ScriptDir%
Gui,BaxterWorks:New
Gui,BaxterWorks:+Owner  ; Definiert BaxterWorks als Unterfenster vom Hauptfenster des Skripts, um dessen Taskleistenschaltfläche zu verstecken.
Gui,BaxterWorks:Margin,15,10
Gui,BaxterWorks:Color, Black
Gui,BaxterWorks:Font, s10 cLime, Verdana
Gui,BaxterWorks:Add,Picture, x-1 y0, %Bax_Start%\Grafix\bw_banner.png
Gui,BaxterWorks:Add,Text, R2 xp+20 yp+90 ,%applicationname% Software Collection`nWähle die Tools, die du starten möchtest.
Gui,BaxterWorks:Font
Gui,BaxterWorks:Font, s9 cWhite, Verdana
Gui,BaxterWorks:Add, Checkbox, vCheck1 Checked%Check1% , EmojiMenu
Gui,BaxterWorks:Add, Checkbox, vCheck2 Checked%Check2% , FavoriteFolders
Gui,BaxterWorks:Add, Checkbox, vCheck3 Checked%Check3% , MiniDBs
Gui,BaxterWorks:Add, Checkbox, vCheck4 Checked%Check4% , NumpadZeichner
Gui,BaxterWorks:Add, Checkbox, vCheck5 Checked%Check5% , DesktopPainter
Gui,BaxterWorks:Add, Checkbox, vCheck6 Checked%Check6% , SuchBax
Gui,BaxterWorks:Add, Button, xm gExitWithoutSaving, schließen
Gui,BaxterWorks:Add, Button, x+2 gExitWithSaving, speichern und beenden
Gui,BaxterWorks:Add, Button, x+2 gToggleall, Alles an/aus
Gui,BaxterWorks:Font
GuiControlGet, Check1
GuiControlGet, Check2
GuiControlGet, Check3
GuiControlGet, Check4
GuiControlGet, Check5
GuiControlGet, Check6
Gui,BaxterWorks:Submit, NoHide
Gui,BaxterWorks:Show, x400 y20, BaxterWorks Config
OnMessage(0x200, "ConfigToolTips")

}

ExitWithSaving:

BaxterWorksGuiClose:      ; wichtige Platzierung genau hier
Gui,BaxterWorks:Submit, NoHide

	If (Check1 = 0)
		IniWrite, 0 , %userini% , Komponenten , Check1
	if (Check1 = 1)
	{
	   	IniWrite, 1 , %userini% , Komponenten , Check1
	   
		If !WinExist("EmojiMenu.exe")
        	run, %Bax_Start%\Apps\Emoji\EmojiMenu.exe
	}


	If (Check2 = 0)
		IniWrite, 0 , %userini% , Komponenten , Check2
	else if (Check2 = 1)
	{
	   	IniWrite, 1 , %userini% , Komponenten , Check2
	   
		If !WinExist("FavoriteFolders.exe")
        	run, %Bax_Start%\Apps\FavFolder\FavoriteFolders.exe
	}


	If (Check3 = 0)
		IniWrite, 0 , %userini% , Komponenten , Check3
	else if (Check3 = 1)
	{
	   	IniWrite, 1 , %userini% , Komponenten , Check3
	   
		If !WinExist("MiniDBs.exe")
        	run, %Bax_Start%\Apps\MiniDB\MiniDBs.exe
	}



	If (Check4 = 0)
		IniWrite, 0 , %userini% , Komponenten , Check4
	else if (Check4 = 1)
	{
	   	IniWrite, 1 , %userini% , Komponenten , Check4
	   
		If !WinExist("NumpadZeichner.exe")
        	run, %Bax_Start%\Apps\NumpadZeichner\NumpadZeichner.exe
	}



	If (Check5 = 0)
		IniWrite, 0 , %userini% , Komponenten , Check5
	else if (Check5 = 1)
	{
	   	IniWrite, 1 , %userini% , Komponenten , Check5
	   
		If !WinExist("DesktopPainter.exe")
        	run, %Bax_Start%\Apps\DesktopPainter\DesktopPainter.exe
	}



	If (Check6 = 0)
		IniWrite, 0 , %userini% , Komponenten , Check6
	else if (Check6 = 1)
	{
	   	IniWrite, 1 , %userini% , Komponenten , Check6
	   
		If !WinExist("SuchBax.exe")
        	run, %Bax_Start%\Apps\SuchBax\SuchBax.exe
	}




WinClose
Gui,BaxterWorks:Destroy
return


ExitWithoutSaving:
WinClose
Gui,BaxterWorks:Destroy
return


Bax_IniRead:
IniRead, Check1, %userini%, Komponenten, Check1 , 0
IniRead, Check2, %userini%, Komponenten, Check2 , 0
IniRead, Check3, %userini%, Komponenten, Check3 , 0
IniRead, Check4, %userini%, Komponenten, Check4 , 0
IniRead, Check5, %userini%, Komponenten, Check5 , 0
IniRead, Check6, %userini%, Komponenten, Check6 , 0
return




;---------------------------------------------------------------->
; ANFANG Funktion 2
;---------------------------------------------------------------->


; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Label Configfenster		                                                                       │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


Toggleall:

Toggle:=!Toggle

checklist=Check1,Check2,Check3,Check4,Check5,Check6

Loop, Parse, checklist, CSV

	{

	 GuiControl, , %A_LoopField%, %Toggle%

	}



Return


ConfigToolTips() {

MouseGetPos,,,, VarControl

IfEqual, VarControl, Button7

	Message := "Mach weg"

else IfEqual, VarControl, Button8

	Message := "Auswahl speichern und loslegen"

else IfEqual, VarControl, Button9

	Message := "Alle Haken oder doch besser gar keinen?"


ToolTip % Message

}
