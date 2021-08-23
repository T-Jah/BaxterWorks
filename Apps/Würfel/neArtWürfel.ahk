CodeVersion := "1.0.0.3", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\wuerfel.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription neArtWürfel
;@Ahk2Exe-SetFileVersion 1.0.0.3
;@Ahk2Exe-SetProductVersion 1.0.0.3
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks neArtWürfel
;@Ahk2Exe-SetProductName neArtWürfel
; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │            __________                  __                __      __             __                         │
; │            \______   \_____  ___  ____/  |_  ___________/  \    /  \___________|  | __  ______             │
; │             |    |  _/\__  \ \  \/  /\   __\/ __ \_  __ \   \/\/   /  _ \_  __ \  |/ / /  ___/             │
; │             |    |   \ / __ \_>    <  |  | \  ___/|  | \/\        (  <_> )  | \/    <  \___ \              │
; │             |______  /(____  /__/\_ \ |__|  \___  >__|    \__/\  / \____/|__|  |__|_ \/____  >             │
; │                    \/      \/      \/           \/             \/                   \/     \/              │
; │              http://www.baxterworks.de/software                      (c) 1999-2021 T-Jah Tom               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 014             M.a.c.r.o.Bax AHK Skript

/*
 * neArtWürfel
 * Copyright 2021 T-Jah Tom
 * All Rights Reserved.
 * Use, reproduction, distribution, and modification of this code is subject to the terms and
 * conditions of the MIT license, available at http://www.opensource.org/licenses/mit-license.php
 *
 * Author: T-Jah Tom
 * Project: https://github.com/T-Jah
 *
 * ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * │   Skriptoptionen  MacroBax                [Version 001]                                                    │
 * └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 *
 *                         BaxterWorks Software:	http://www.baxterworks.de/software
 *			                 http://blog.baxterworks.de
 *                                       ^ STRG + Shift ! Alt # WIN
 * 
 */

; Script options
	#SingleInstance force 			; oder off, ignore, force
	#NoEnv
	#MaxMem 512			
	#Persistent
	#InstallKeybdHook
	#InstallMouseHook
		SetBatchLines -1
		DetectHiddenWindows On		; Ermöglicht die Erkennung des versteckten Hauptfensters eines Skripts.
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %A_ScriptDir%	; wichtig
		FileEncoding UTF-8
		ListLines, Off			; spart Ressourcen wenn aus. Zum Debuggen einschalten für most recently executed lines
; Icon
	Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\wuerfel.ico	; #NoTrayIcon
; OnExit
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   MacroBax  Variablen, zB Pfade     [Version 004]                                                                    │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Startumgebungsvariablen laden
	IniRead, Bax_Start , %A_ScriptDir%\..\..\Config\BaxterWorks.ini, FixVars, Bax_Start
	IniRead, homeini , %Bax_Start%\Config\BaxterWorks.ini, FixVars, homeini
	IniRead, userini , %homeini%, FixVars, userini
	IniRead, Bax_Bar , %homeini%, FixVars, Bax_Bar
	IniRead, backuptxt , %homeini%, FixVars, backuptxt
	IniRead, Bax_exe , %homeini%, FixVars, Bax_exe
	IniRead, FensterVersion , %homeini%, FixVars, FensterVersion
	IniRead, Erstnutzung , %userini%, %A_UserName%_%A_ComputerName%, Erstnutzung

; Startumgebungsvariablen festlegen
	AppName = neArtWürfel
	Bax_help = help_wuerfel	
	Skriptvorlage = MacroBax_014
	Bax_Icon = %Bax_Start%\Grafix\wuerfel.ico
	LastLogIn = %A_Now%_%AppName%
	LastLogInZeit = %A_Now%
	LetzteAnmeldung = %A_UserName%
	LetzterEinsatz = %A_ComputerName%
	BaxNutzerName = %A_UserName%_%A_ComputerName%
	Bax_Start = %Bax_Start%
	scriptini = %Bax_Start%\Config\%AppName%.ini
	
; Variablentest
; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox,  %homeini% 


;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │               Appstart MacroBax         [Version 002]    + checkt die Würfel                               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

	if !FileExist("wuerfel.txt")
	{
	MsgBox, 0,BaxterWorks Software meldet , Die Würfel werden erstellt - es kann losgehen, 2
	GoSub,Wmaker1
	}
	if !FileExist("wuerfel2.txt")
	{
	GoSub,Wmaker2
	}


	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Stats.ahk
	GoSub,TRAYMENU
	GoSub,STATS
	

;-----Skript------------------------------------------



	
Gui,Wuerfel:New
Gui,Wuerfel:+Owner +Alwaysontop ; Definiert BaxterWorks als Unterfenster vom Hauptfenster des Skripts, um dessen Taskleistenschaltfläche zu verstecken.
Gui,Wuerfel:Margin,15,10
Gui,Wuerfel:Color, Black
Gui,Wuerfel:Font, s10 cLime, Verdana
Gui,Wuerfel:Add, Text, x10 y10 R2, "Iss dat jetzt nen Würfel`noder nur so neArtWürfel?"
Gui,Wuerfel:Font
Gui,Wuerfel:Font, s9 cWhite, Verdana
Gui,Wuerfel:Add, button, x10 y+10 gWürfel, mit einem Würfel
Gui,Wuerfel:Add, button, x+10 gWürfel2, mit 2 Würfeln
Gui,Wuerfel:Font
Gui,Wuerfel:Font, s12 cWhite, Verdana
Gui,Wuerfel:Add, Text, x10 y+20, Ergebnis: 
Gui,Wuerfel:Add, Edit,ReadOnly x+10, %Var%
GuiControl,Hide, Edit,
GuiControl,,Edit1, %Var% ; aktualisieren
Gui,Wuerfel:Font
Gui,Wuerfel:Font, s9 cWhite, Verdana
Gui,Wuerfel:Add, Text, x10 y+10, Wurf-Nr.: 
Gui,Wuerfel:Add, Edit,ReadOnly x+10, %count%
GuiControl,Hide, Edit,
GuiControl,,Edit2, %count% ; aktualisieren
Gui,Wuerfel:Font
Gui,Wuerfel:Show, Autosize ,%AppName%

Textdateipfad = %A_ScriptDir%\wuerfel.txt
Dateipfad = %A_ScriptDir%\wuerfel2.txt
count = 0
Loop,
{
  FileReadLine, Ausgabevariable, %Textdateipfad%, %A_Index%
  If Errorlevel
  {
    Zeilenanzahl := A_Index-1
    break
  }
}
Loop, 2
{
  Random, rand , 1, %Zeilenanzahl%
  FileReadLine, Var, %Textdateipfad%, %rand%
  Send, %Var%
  Return
}



Würfel:
	Random, rand , 1, %Zeilenanzahl%
	FileReadLine, Var, %Textdateipfad%, %rand%
	GuiControl,Hide, Edit,
	GuiControl,,Edit1, %Var% ; aktualisieren
  	count++
	GuiControl,,Edit2, %count% ; aktualisieren
	return

Würfel2:
	Random, rand , 1, %Zeilenanzahl%
	FileReadLine, Var, %Dateipfad%, %rand%
	GuiControl,Hide, Edit,
	GuiControl,,Edit1, %Var% ; aktualisieren
	count++
	GuiControl,,Edit2, %count% ; aktualisieren
	return


Wmaker1:
	FileAppend,
	(
Eins
Zwei
Drei
Vier
Fünf
Sechs
Eins
Zwei
Drei
Vier
Fünf
Sechs
Eins
Zwei
Drei
Vier
Fünf
Sechs
Eins
Zwei
Drei
Vier
Fünf
Sechs
Eins
Zwei
Drei
Vier
Fünf
Sechs
Eins
Zwei
Drei
Vier
Fünf
Sechs
Eins
Zwei
Drei
Vier
Fünf
Sechs
) , wuerfel.txt
	return

Wmaker2:
	FileAppend,
	(
Einerpasch
Zweierpasch
Dreierpasch
Viererpasch
Fünferpasch
Sechserpasch
Eins und Eins
Eins und Zwei (Meier)
Eins und Drei
Eins und Vier
Eins und Fünf
Eins und Sechs
Zwei und Eins (Meier)
Zwei und Zwei
Zwei und Drei
Zwei und Vier
Zwei und Fünf
Zwei und Sechs
Drei und Eins
Drei und Zwei
Drei und Drei
Drei und Vier
Drei und Fünf
Drei und Sechs
Vier und Eins
Vier und Zwei
Vier und Drei
Vier und Vier
Vier und Fünf
Vier und Sechs
Fünf und Eins
Fünf und Zwei
Fünf und Drei
Fünf und Vier
Fünf und Fünf
Fünf und Sechs
Sechs und Eins
Sechs und Zwei
Sechs und Drei
Sechs und Vier
Sechs und Fünf
Sechs und Sechs
) ,wuerfel2.txt
	return


;-----Skriptende--------------------------------------
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MusterBax Stats     [Version 003]                                                                           │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;
STATS:
	
	Bax_Stats_Nutzungstage()
	;MsgBox, %Nutzungstage% Tage seit Installation
	IniWrite, %Nutzungstage% , %scriptini%, Stats_%BaxNutzerName% , Nutzungstage
	
  	Bax_Stats_Zwischenzeit()
	;MsgBox, %Zwischenzeit% Minuten seit deinem letzten Besuch
	IniWrite, %Zwischenzeit% , %scriptini%, Stats_%BaxNutzerName% , Zwischenzeit

	Bax_Stats_Zeilenzahl()
	IniWrite, %Appnutzcount% , %scriptini%, Stats_%BaxNutzerName% , Appnutzcount

	FileAppend, %A_Now% | %CodeVersion% | %Fensterversion% | %Skriptvorlage% | %AppName% | Starts: %Appnutzcount% | Pause: %Zwischenzeit% Stunden | Nutzung: %Nutzungstage% Tage`n , %Bax_Start%\Log\%AppName%log.txt

return

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   EndSub MacroBax        [Version 007]                                                                     │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


GuiEscape:
GuiClose:
ButtonCancel:
quit:
	IniWrite, %LetzteAnmeldung% , %scriptini%, Nutzerinfo, Letzter Nutzer
	IniWrite, %LetzterEinsatz% , %scriptini%, Nutzerinfo, Letzter Rechner
	IniWrite, %FensterVersion% , %scriptini%, Nutzerinfo, FensterVersion
	IniWrite, %Skriptvorlage% , %scriptini%, Nutzerinfo, Skriptvorlage
	IniWrite, %A_Now% , %scriptini%, Nutzerinfo, LastLogIn
	IniWrite, %A_Now% , %scriptini%, Stats_%BaxNutzerName% , LastLogInZeit

	FormatTime, LastSeen,, LongDate
	IniWrite, %Lastseen% , %backuptxt%, Stats_%BaxNutzerName% , Lastseen
	IniWrite, %A_Now%_%AppName% , %backuptxt%, Stats_%BaxNutzerName% , LastLogIn
	IniWrite, %AppName%_%CodeVersion%_%Skriptvorlage%_%A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzung_%AppName%
	IniWrite, %A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzzeit_%AppName%
FileAppend, Nutzung: %A_Now% %A_Tab% Nutzer: %BaxNutzerName% %A_Tab% App: %AppName%_%CodeVersion% %A_Tab% Skriptvorlage: %Skriptvorlage%`n , %Bax_Start%\Config\%A_ComputerName%.bax

	FileDelete, %A_ScriptDir%\*.txt
ExitApp

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   SubTray MacroBax         [Version 005]                                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

About:
	MsgBox, 64, About, Mehr über BaxterWorks Software findest du im Netz:`nhttp://www.BaxterWorks.de/software`nCredits an das offizielle Handbuch.`n`nDownload: https://github.com/T-Jah
	return

helptray:
If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/%Bax_help%.htm, %A_ScriptDir%\..\..\Files\%Bax_help%.htm
	}
	run,%A_ScriptDir%\..\..\Files\%Bax_help%.htm
	return
Credits:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/Credits.htm, %Bax_Start%\Files\Credits.htm
	}
	run, %Bax_Start%\Files\Credits.htm
	return
Version:
	Run,%Bax_Start%\Log\Versionsinfo_%AppName%.txt
	return
Reload:
	reload
	return

OpenGUI:
	Gui,Wuerfel:Show, Center Autosize, %AppName%
	;GoSub,About
	return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Traymenü   MacroBax            [Version 003]                                                        │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

TRAYMENU:
	Menu, Tray, NoStandard
	Menu, Tray, DeleteAll
	Menu, Tray, NoMainWindow
	Menu, Tray, Add, %AppName%, OpenGUI
	Menu, Tray, Add						; Trennlinie
	Menu, Tray, Add, Über diese App, About
	Menu, Tray, Add, Hilfe, helptray
	Menu, Tray, Add, Versionsinfo, version
	Menu, Tray, Add, Credits, Credits
	Menu, Tray, Add
	Menu, Tray, Add, Reload, reload
	Menu, Tray, Add, Exit, quit
	Menu, Tray, Default, %AppName%
	Menu, Tray, Tip, %AppName%  %Codeversion%
	return
