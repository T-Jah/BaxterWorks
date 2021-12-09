﻿CodeVersion := "1.0.2.5", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\menuico.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription 00AppBar - Einstellungen der BWAppBar
;@Ahk2Exe-SetFileVersion 1.0.2.5
;@Ahk2Exe-SetProductVersion 1.0.2.5
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks 00AppBar
;@Ahk2Exe-SetProductName 00AppBar
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
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 030          M.u.s.t.e.r.Bax AHK Skript

/*
 * 00AppBar
 * Copyright 2021 T-Jah Tom
 * All Rights Reserved.
 * Use, reproduction, distribution, and modification of this code is subject to the terms and
 * conditions of the MIT license, available at http://www.opensource.org/licenses/mit-license.php
 *
  * Author: T-Jah Tom
 * Project: https://github.com/T-Jah
 *
 * ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * │   Skriptoptionen 	MusterBax              [Version 005]                                                    │
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
	Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\menuico.ico	; #NoTrayIcon

; OnExit
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk


;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Variablen, MusterBax zB Pfade     [Version 008]                                                          │
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
	AppName = 00AppBar
	Bax_help = help_bwappbar	
	Skriptvorlage = MusterBax_030
	Bax_Icon = %Bax_Start%\Grafix\menuico.ico
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
; │   AppStart MusterBax mit Subanweisung         [Version 006]                                                │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

/** IP Logbuch, archiviert die eigene externe IP
	URLDownloadToFile,http://www.netikus.net/show_ip.html, %Bax_Start%\Files\IP Logbuch\showip_%A_YYYY%_%A_MM%_%A_DD%.txt
	if ErrorLevel = 1
  	{
    	MsgBox, 16,IpAddresses,Your public Ipaddress could not be detected.
  	}
	FileReadLINE,BaxIP,%Bax_Start%\Files\IP Logbuch\showip_%A_YYYY%_%A_MM%_%A_DD%.txt, 1
	IniWrite, %BaxIP% , %scriptini%, Netzinfo, Letzte IP

Hinweis: Standardmäßig deaktiviert, sollte nur in einem Skript verwendet werden, das regelmäßig läuft
*/

;---------------------------------------------------------------->
; AppStart (AutoExec Bereich geht nach dem letzten Eintrag weiter)
; Also hier nach Traymenü.
;---------------------------------------------------------------->

Process, Exist, BaxterWorks.exe
        If ErrorLevel
           	GoTo,AppStart
        Else
            	Run, %Bax_Start%\BaxterWorks.exe
		GoTo,AppStart


AppStart:

	GoSub,INIDELETE
	GoSub,INIREAD
	GoSub,INIWRITE
	GoSub,TRAYMENU
	GoSub,STATS
	
	


;---------------------------------------------------------------->
; Ende AutoExec (kein return wegen includes)
;---------------------------------------------------------------->

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Includes (Ende Autoexec)  MusterBax      [Version 009]                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

#Persistent  							; Verhindert, dass sich das Skript automatisch beendet.
; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox, %Bax_ScriptStart%

; BaxFunk Module
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_FensterInfo.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_backuptxt.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_VarSchau.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Keys.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_IconShow.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_LicenceWindow.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_2Win.ahk
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Dropper.ahk
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_ConfigWindow.ahk
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Progress.ahk
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_reloadAHK.ahk
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Stats.ahk
	#Include %A_ScriptDir%\..\..\Lib\datecalc.ahk
	#include %A_ScriptDir%\..\..\Lib\funk_panic.ahk
	#Include %A_ScriptDir%\..\..\Lib\funk_toggle.ahk
	#Include %A_ScriptDir%\..\..\Lib\Gdip_all.ahk
	#Include %A_ScriptDir%\..\..\Lib\ipfindmap.ahk
	#Include %A_ScriptDir%\..\..\Lib\keepalive.ahk
	#Include %A_ScriptDir%\..\..\Lib\MouseisOver.ahk
	#Include %A_ScriptDir%\..\..\Lib\ObjCSV.ahk
	#Include %A_ScriptDir%\..\..\Lib\tf.ahk
	#Include %A_ScriptDir%\..\..\Lib\toolbar.ahk
	#Include %A_ScriptDir%\..\..\Lib\toggle_hiddenfiles.ahk
	#Include %A_ScriptDir%\..\..\Lib\toggle_lightdark.ahk


	Gdip_Startup()
	
;-------------------------------------------------------Ende AutoExec
	return
;-------------------------------------------------------Ende AutoExec

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Traymenü   MusterBax        [Version 001]                                                           │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

TRAYMENU:
Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray,NoMainWindow
Menu,Tray,Add,%AppName%,OpenGUI
Menu,Tray,Add						; Trennlinie
Menu,Tray,Add,&Licence...,Licence
Menu,Tray,Add,&credits...,credits
Menu,Tray,Add,&About...,About
Menu,Tray,Add,&Hilfe...,HilfeTray
Menu,Tray,Add						; Trennlinie
Menu,Tray,Add,&Variablen...,Variablen
Menu,Tray,Add,&HotKeys...,HotKeys
Menu,Tray,Add,&Reload...,Reload
Menu,Tray,Add						; Trennlinie
Menu,Tray,Add,&Settings...,EINSTELLUNGEN
Menu,Tray,Add,&Neuerungen...,Version
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Tip,%AppName% %Codeversion%
Menu,Tray,Default,%AppName%

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Dateimenü, MusterBax          [Version 003]                                                         │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


Menu, Dateimenü, Add, reload, Config
Menu, Dateimenü, Icon, reload, C:\WINDOWS\System32\SHELL32.dll,147
Menu, Dateimenü, Add, Exit, Beenden
Menu, Dateimenü, Icon, Exit, C:\WINDOWS\System32\SHELL32.dll,28

Menu, Configmenü, Add, Toggle DesktopSymbol, %AppName%_Icon 
Menu, Configmenü, ToggleCheck, Toggle DesktopSymbol       
Menu, Configmenü, Add, Toggle BaxBarSymbol, %AppName%_BaxBar 
Menu, Configmenü, ToggleCheck, Toggle BaxBarSymbol       
Menu, Configmenü, Add, Toggle FensterInfo, %AppName%_FensterInfo 
Menu, Configmenü, ToggleCheck, Toggle FensterInfo       
Menu, Configmenü, Add, GetReadyBax - Config, GetReady 
Menu, Configmenü, Icon, GetReadyBax - Config,  ..\..\Grafix\runaway.ico, 0   

Menu, Toolsmenü, Add, IconShow, MenuIconShow
Menu, Toolsmenü, Icon, IconShow, C:\WINDOWS\System32\SHELL32.dll,23
Menu, Toolsmenü, Add, Link Extractor, MenuLinksEx
Menu, Toolsmenü, Icon, Link Extractor, C:\WINDOWS\System32\SHELL32.dll,136
Menu, Toolsmenü, Add, Dropperfenster laden, DropperMenu
Menu, Toolsmenü, Icon, Dropperfenster laden, C:\WINDOWS\System32\SHELL32.dll,27
Menu, Toolsmenü, Add, Skripte killen: Panikbutton, Panik
Menu, Toolsmenü, Icon, Skripte killen: Panikbutton, ..\..\Grafix\killerbax.ico, 0

Menu, Baxmenü, Add, BaxterWorks Software, Homepage
Menu, Baxmenü, Add, Blog BaxterWorks, Blog
Menu, Baxmenü, Add, Home Tom Besch, HPTom
Menu, Baxmenü, Add, GitHub T-Jah Tom, GitHub
Menu, Baxmenü, Icon, BaxterWorks Software, ..\..\Grafix\bw_software.ico, 0
Menu, Baxmenü, Icon, Blog BaxterWorks, ..\..\Grafix\bax.ico, 0
Menu, Baxmenü, Icon, Home Tom Besch, ..\..\Grafix\logo_tb2.ico, 0
Menu, Baxmenü, Icon, GitHub T-Jah Tom, ..\..\Grafix\github1.ico, 0

Menu, Hilfsmenü, Add, credits, Menucredits
Menu, Hilfsmenü, Icon, credits, C:\WINDOWS\System32\SHELL32.dll,131
Menu, Hilfsmenü, Add, Info, MenuInfo
Menu, Hilfsmenü, Icon, Info, C:\WINDOWS\System32\SHELL32.dll,222
Menu, Hilfsmenü, Add, Software Lizenz, Lizenzmenu
Menu, Hilfsmenü, Icon, Software Lizenz, C:\WINDOWS\System32\SHELL32.dll,327
Menu, Hilfsmenü, Add, Hilfe, MenuHilfe
Menu, Hilfsmenü, Icon, Hilfe, C:\WINDOWS\System32\SHELL32.dll,173
Menu, Hilfsmenü, Add, Tom unterstützen, MenuSupport
Menu, Hilfsmenü, Icon, Tom unterstützen, C:\WINDOWS\System32\SHELL32.dll,177

Menu, MeineMenüleiste, Add, &Datei, :Dateimenü
Menu, MeineMenüleiste, Add, Einstellungen, :Configmenü
Menu, MeineMenüleiste, Add, Tools, :Toolsmenü
Menu, MeineMenüleiste, Add, BaxterWorks, :Baxmenü
Menu, MeineMenüleiste, Add, ?, :Hilfsmenü

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Fenster, Teil 1 MusterBax  [Version 001]                                                            │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

Gui, Font, s10 cWhite, Verdana,Tahoma
Gui, Margin, 0, 10
Gui, Color, White

	IniRead, Pos, %scriptini%, Position, %AppName%_Position
	If (Pos = "ERROR") {
	IniWrite, x40 y40, %scriptini%, Position, %AppName%_Position
	Gui, Show, x40 y40, 00AppBar Error
	}
	Else

; -------------------------------------------------------------------------------------------
	IniRead, %AppName%_Icon, %scriptini%, Schalter, %AppName%_Icon

	If (00AppBar_Icon = "1") {
	Menu, Configmenü, Check, 1&
	}
	If (00AppBar_Icon = "0") {
	Menu, Configmenü, UnCheck, 1&
	}


; -------------------------------------------------------------------------------------------

	IniRead, %AppName%_BaxBar, %scriptini%, Schalter, %AppName%_BaxBar


	If (00AppBar_BaxBar = "1") {
	Menu, Configmenü, Check, 2&
	}
	If (00AppBar_BaxBar = "0") {
	Menu, Configmenü, UnCheck, 2&
	}

; -------------------------------------------------------------------------------------------

	IniRead, %AppName%_FensterInfo, %scriptini%, Schalter, %AppName%_FensterInfo

	If (00AppBar_FensterInfo = "1") {
	Menu, Configmenü, Check, 3&
	}
	If (00AppBar_FensterInfo = "0") {
	Menu, Configmenü, UnCheck, 3&
	}

; -------------------------------------------------------------------------------------------

Gui,Menu, MeineMenüleiste
Gui, Font
Gui, Font, s12 cBlack, Verdana,Tahoma
Gui,Add,Picture, x-1 y25 w600 h-1, ..\..\Grafix\bw_banner.png

	IniRead, 00AppBar_AOTStatus, %scriptini%, Schalter, 00AppBar_AOTStatus
	If (00AppBar_AOTStatus = "1") {
	Gui,+AlwaysOnTop
	}
	IniRead, 00AppBar_AOT, %scriptini%, Schalter, 00AppBar_AOT
	If (00AppBar_AOT = "-") {
	WinSet, AlwaysOnTop, Off
	}
	else 
	00AppBar_AOT := +
	WinSet, AlwaysOnTop, On

Gui, Add, CheckBox, x5 y+5 v00AppBar_AOTStatus gAOTLabel Checked%00AppBar_AOT%, Always on top
Gui, Font

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Fenster, Teil 2 [ohne Versionsnummer]                                                               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

Gui, Font, s12 cBlack, Verdana,Tahoma
Gui,Add,Picture, x15 y+5 w64 h-1, ..\..\Grafix\gta_moped2.ico
Gui,Add,Text, x130 y150 R2, Einzelne Verknüpfungen für Startmenü, Desktop`noder die BaxterWorks AppBar erstellen.
Gui, Font

Gui, Font, s10 cBlack, Verdana,Tahoma
Quelle1 := ""
Gui, Add, DropDownList, x130 y200 vLNK gLNKddl, Startmenü|Desktop|AppBar
Gui,Add,Text, x+10, Wohin soll die Verknüpfung?
Gui, Add, Edit, x10 y230 w390 R1 vQuelle1, %Quelle1%
GuiControlGet, Quelle1
GuiControlGet, LNK
Gui, Add, Button, x+3 gQuellesuchen, Programm wählen
Gui, Add, Button, x10 y+10 gButtonGo, Verknüpfung anlegen
Gui, Add, Button, x+3 gButtonEnde, Beenden
Gui, Font
Gui, Font, s12 cBlack, Verdana,Tahoma
Gui,Add,Text, x130 y325 R2, Mehrere Verknüpfungen für Startmenü, Desktop`noder die BaxterWorks AppBar erstellen.
Gui, Font

Gui,Add,Picture, x15 y325 w70 h-1, ..\..\Grafix\logo_tjah2.ico
Gui, Font, s10 cBlack, Verdana,Tahoma
Quelle2 := ""
Gui, Add, DropDownList, x130 y375 vLNK2 gLNKddl2, Startmenü|Desktop|AppBar
Gui,Add,Text, x+10, Wohin sollen die Verknüpfungen?
Gui, Add, Edit, x10 y405 w390 R1 vQuelle2, %Quelle2%
GuiControlGet, Quelle2
GuiControlGet, LNK2
Gui, Add, Button, x+3 gQuellesuchen2, Ordner wählen
Gui, Add, Button, x10 y+10 gButtonGo2, Verknüpfungen anlegen
Gui, Add, Button, x+3 gButtonEnde2, Beenden

Gui, Font

Gui, Show, %Pos% w600, %AppName%
Gui, Submit , NoHide

OnMessage(0x200, "CheckControl")

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Toolbar, MusterBax           [Version 001]              				               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

	hToolbar := CreateToolbar()
	return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, TrayFensterFenster (About), MusterBax                   [Version 001]                               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

ABOUT:
Gui,99:Destroy
Gui,99:Margin,20,20
Gui,99:Color, silver

Gui,99:Add,Picture, w90 h90 Icon1,%AppName%.exe
Gui,99:Font,Bold 
Gui,99:Font, s10 cGreen, Verdana
Gui,99:Add,Text, R1 xp+100 ,%AppName% - %Firma% - %Codeversion% 
Gui,99:Font
Gui,99:Font, s9 cBlack, Verdana
Gui,99:Add,Text, R3 ,Menüfunktion der BWAppBar und Tool für Verknüpfungen.`nauf dieser Leiste - Das ist 00AppBar`nFunktioniert.
Gui,99:Font,cBlue bold Underline
Gui,99:Add,Text,R1 gBWApp,www.baxterworks.de/software
Gui,99:Font

Gui,99:Add,Picture,xs w70 h70 Icon1,%A_ScriptDir%\..\..\Grafix\BW_Software.ico
Gui,99:Font,Bold
Gui,99:Font, s10 cBlack, Verdana
Gui,99:Add,Text, R1 xp+100 ,%Firma%
Gui,99:Font
Gui,99:Font, s9 cBlack, Verdana
Gui,99:Add,Text,R3 ,Auf der Webseite findest du weitere Apps,`nein paar Codeschnippsel und Informationen`nzur Software.
Gui,99:Font,CBlue bold Underline
Gui,99:Add,Text,y+5 gBWSoft,www.baxterworks.de/software
Gui,99:Font

Gui,99:Add,Picture,xs w70 h70 Icon1,%A_ScriptDir%\..\..\Grafix\bax.ico
Gui,99:Font,Bold
Gui,99:Font, s10 cBlack, Verdana
Gui,99:Add,Text, R1 xp+100 ,Blog BaxterWorks
Gui,99:Font
Gui,99:Font, s9 cBlack, Verdana
Gui,99:Add,Text,R3 ,Die ungefragte Meinung`nIn unregelmäßigen Abständen melde ich mich dort zu Wort.`nMöglichkeit der Kontaktaufnahme ist gegeben.
Gui,99:Font,CBlue bold Underline
Gui,99:Add,Text,y+5 gBWBlog,blog.baxterworks.de
Gui,99:Font

Gui,99:Add,Picture,xs w70 h70 Icon1,%A_ScriptDir%\..\..\Grafix\ahk.ico
Gui,99:Font,Bold
Gui,99:Font, s10 cBlack, Verdana
Gui,99:Add,Text, R1 xp+100 ,AutoHotKey
Gui,99:Font
Gui,99:Font, s9 cBlack, Verdana
Gui,99:Add,Text,R3 ,Dieses Tool wurde mit AutoHotKey erstellt`nStichwort Lowcode Programmierung`nMehr Info und kostenloser Download:
Gui,99:Font,CBlue Underline
Gui,99:Add,Text,y+5 gAHKlabel,www.AutoHotkey.com
Gui,99:Font

Gui,99:Show,,%AppName% About
hCurs:=DllCall("LoadCursor","UInt",NULL,"Int",32649,"UInt") ;IDC_HAND
OnMessage(0x200,"WM_MOUSEMOVE") 
Return


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MusterBax Stats     [Version 004]                                                                           │
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

	FileAppend, %A_Now% | %CodeVersion% | %Fensterversion% | %Skriptvorlage% | %AppName% | Starts: %Appnutzcount% | Pause: %Zwischenzeit% Stunden | Nutzung: %Nutzungstage% Tage`n , %Bax_Start%\Files\Log\%AppName%_log.txt

return





; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Funktionen Standard MusterBax [Version 002]      Tooltips immer unterschiedlich                          │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Tooltips für die GUI

CheckControl() {
MouseGetPos,,,, VarControl
IfEqual, VarControl, Button1
	Message := "An oder Aus - entscheide dich"
else IfEqual, VarControl, Button2
	Message := "Was soll verknüpft werden?"
else IfEqual, VarControl, Button3
	Message := "Auswahl bestätigen"
else IfEqual, VarControl, Button4
	Message := "Programm beenden, Fenster schließen"
else IfEqual, VarControl, Button5
	Message := "Was soll verknüpft werden?"
else IfEqual, VarControl, Button6
	Message := "Auswahl bestätigen"
else IfEqual, VarControl, Button7
	Message := "Programm beenden, Fenster schließen"
else IfEqual, VarControl, Combobox1
	Message := "Bitte zuerst einen Ziel wählen."
else IfEqual, VarControl, Combobox2
	Message := "Bitte zuerst einen Ziel wählen."
ToolTip % Message
}

;--------------------------------------------------------

; Dropfiles GUI

GuiDropFiles(GuiHwnd, DateiArray, ElementHwnd, X, Y) {
	for i, Datei in DateiArray
		MsgBox Datei %i% ist:`n%Datei%`n`nKeine Ahnung, was ich jetzt damit machen soll.`n`nVerknüpfungen per DragnDrop anzulegen ist für eine spätere Version geplant
}

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Funktionen Toolbar    MusterBax    [Version 007]                                                         │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

CreateToolbar() {
    ImageList := IL_Create(10)
    IL_Add(ImageList, "..\..\Grafix\bax.ico", 0)
    IL_Add(ImageList, "shell32.dll", 45)
    IL_Add(ImageList, "..\..\Grafix\welt.ico", 0)
    IL_Add(ImageList, "shell32.dll", 259)
    IL_Add(ImageList, "..\..\Grafix\bw_2win.ico", 0)
    IL_Add(ImageList, "..\..\Grafix\klee.ico", 0)
    IL_Add(ImageList, "shell32.dll", 44)
    IL_Add(ImageList, "..\..\Grafix\geld.ico", 0)
    IL_Add(ImageList, "..\..\Grafix\info.ico", 0)
    IL_Add(ImageList, "shell32.dll", 28)

    Buttons = 
    (LTrim
        BaxterWorks Menü
	HotKeys in der Übersicht
        SuchBax - MultisearchTool
	iSafeText - sichert Text aus der Zwischenablage in Bax_JobDir
	2win - Zwei Explorerfenster plus Notizblatt 
	VarSchau ist keine Stadt
	Deine Lieblingsapp starten
        Donate - Unterstützung für Tom
        Hilfetexte
	Beenden
    	)
    	Return ToolbarCreate("OnToolbar", Buttons, ImageList, "Flat List Tooltips")
	}

OnToolbar(hWnd, Event, Text, Pos, Id) {
    	If (Event != "Click") {
        Return
    	}
	If (Text == "BaxterWorks Menü") {
		;MsgBox, 0,, BaxterWorks Menü mit STRG+1, 2
		send,{Ctrl down}1{Ctrl up}
    		Gui,Submit,NoHide
		
	} Else If (Text == "HotKeys in der Übersicht") {
		;MsgBox, 0,, HotKeyFenster mit STRG+2, 4
		BaxProgressBar()
		
		send,{Ctrl down}2{Ctrl up}
		Gui,Submit,Hide
		
    	} Else If (Text == "SuchBax - MultisearchTool") {
		;MsgBox, 0,, BaxterWorks Suche mit STRG+5, 4
		send,{Ctrl down}5{Ctrl up}
		Gui,Submit,Hide

    	} Else If (Text == "iSafeText - sichert Text aus der Zwischenablage in Bax_JobDir") {
		BaxFunk_backuptxt()
		
    	} Else If (Text == "2win - Zwei Explorerfenster plus Notizblatt") {
		;MsgBox, 0,, Die Funktion 2win wird aufgerufen, 4
		Bax_2Win_start()
		Gui,Submit,Hide
		
    	} Else If (Text == "VarSchau ist keine Stadt") {
		;MsgBox, 0,, Die Funktion VarSchau wird aufgerufen, 4
		BaxFunk_VarSchau()
		Gui,Submit,Hide
		
    	} Else If (Text == "Deine Lieblingsapp starten") {
		IniRead, Bax_Flex, %A_ScriptDir%\..\..\Config\%A_UserName%_%A_ComputerName%.ini, UserVars, Bax_Flex
 		;MsgBox, 0,, Die Funktion %Bax_Flex% wird aufgerufen, 4
		run,%Bax_Flex%        	
		Gui,Submit,Hide
		
    	} Else If (Text == "Donate - Unterstützung für Tom") {
		MsgBox, 0,, Tom braucht deinen Support, 2
		run, https://www.tombesch.de/konto.htm
		Gui,Submit,Hide
		
    	} Else If (Text == "Hilfetexte") {
		MsgBox, 0,, Hilfe ist unterwegs - BaxterWorks Hilfeseiten, 4
		run, http://www.baxterworks.de/software/hilfe/help.htm
		Gui,Submit,Hide
		
    	} Else If (Text == "Beenden") {
		MsgBox, 0,, BaxterWorks sagt tüss,2
		GoSub,EXIT
    }

}
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Funktionen von diesem Skript    MusterBax                                                                │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

LNKddl:
Gui, Submit,NoHide
if (LNK = "Desktop") {
	Befehl = %A_Desktop%\

}
if (LNK = "Startmenü") {
	Befehl = %A_StartMenu%\Programme\

}
if (LNK = "AppBar") {
	Befehl = %A_AppData%\Microsoft\Internet Explorer\Quick Launch\

}
return

LNKddl2:
Gui, Submit,NoHide
if (LNK2 = "Desktop") {
	Befehl2 = %A_Desktop%\BaxterWorks\

}
if (LNK2 = "Startmenü") {
	Befehl2 = %A_StartMenu%\Programme\BaxterWorks\

}
if (LNK2 = "AppBar") {
	Befehl2 = %A_AppData%\Microsoft\Internet Explorer\Quick Launch\

}
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Label und Subs MusterBax   [Version 001]                                                                 │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
; 


;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Sub Ini MusterBax [Version 011]                                                                          │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

INIDELETE:
	IniDelete, %scriptini%, Nutzerinfo, 

INIREAD:
	IniRead, Bax_IP , %homeini%, Netzinfo, Letzte IP
	IniRead, Ziel1, %userini%, UserVars, Ziel1
	IniRead, Ziel2, %userini%, UserVars, Ziel2 
	IniRead, DeinOrdner1, %userini%, UserVars, DeinOrdner1
	IniRead, DeinOrdner2, %userini%, UserVars, DeinOrdner2
	IniRead, Bax_JobDir, %userini%, UserVars, Bax_JobDir
	IniRead, Bax_Flex, %userini%, UserVars, Bax_Flex

INIWRITE:
	IniWrite, %LetzteAnmeldung% , %scriptini%, Nutzerinfo, Letzter Nutzer
	IniWrite, %LetzterEinsatz% , %scriptini%, Nutzerinfo, Letzter Rechner
	IniWrite, %Bax_IP% , %scriptini%, Nutzerinfo, Bax_IP
	IniWrite, %FensterVersion% , %scriptini%, Nutzerinfo, FensterVersion
	IniWrite, %Skriptvorlage% , %scriptini%, Nutzerinfo, Skriptvorlage
	IniWrite, %A_Now%_%AppName% , %scriptini%, Stats_%BaxNutzerName% , LastLogIn
	IniWrite, %A_Now% , %scriptini%, Stats_%BaxNutzerName% , LastLogInZeit
return

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs GUI-Fenster   MusterBax    [Version 001]                                                            │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Always on Top Toggle, gehört zur Checkbox in der GUI, sofern vorhanden.

AOTLabel:
	Gui,Submit,NoHide
	IniWrite, %00AppBar_AOTStatus%, %scriptini%, Schalter, 00AppBar_AOTStatus

; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox, %00AppBar_AOTStatus%  ; sollte 0 oder 1 sein

	if (00AppBar_AOTStatus=1)
	{
	WinSet, AlwaysOnTop, On
	IniWrite, + , %scriptini%, Schalter, 00AppBar_AOT
	}
	else
	{
	WinSet, AlwaysOnTop, Off
	IniWrite, - , %scriptini%, Schalter, 00AppBar_AOT
	}
	Return


Quellesuchen:
	FileSelectFile, Quelle1, 3, , Datei öffnen, Ausführbare (*.exe; *.bat; *.cmd; *.com)
	if Quelle1 =
    	MsgBox, Keine Datei ausgewählt.
	else
    	GuiControl,, Quelle1, %Quelle1%

;------------------------------------------------------------------TestBox
	;MsgBox, Der Benutzer hat folgendes ausgewählt:`n%Quelle1%

	return

ButtonGo:
	FileCreateDir, %Befehl%
	SplitPath, % Quelle1, AusNameOhneEnd

;------------------------------------------------------------------TestBox
	;MsgBox, Der Benutzer hat diesen Namen gewählt:`n%AusNameOhneEnd%

	FileCreateShortcut, %Quelle1%, %Befehl%\%AusNameOhneEnd%.lnk, 0
	return

ButtonEnde:
	PostMessage, 0x0112, 0xF060,,, %AppName%  ; 0x0112 = WM_SYSCOMMAND, 0xF060 = SC_CLOSE
	return

;-----------------------------------------------------------------------------------------------

Quellesuchen2:
	FileSelectFolder, Quelle2, %Quelle2%
	if Quelle2 =
    	MsgBox, Keine Datei ausgewählt.
	else
    	GuiControl,, Quelle2, %Quelle2%

;------------------------------------------------------------------TestBox
;MsgBox, Der Benutzer hat folgendes ausgewählt:`n%Quelle2%

	return

ButtonGo2:
	Quelle2 = %Quelle2%

;------------------------------------------------------------------TestBox
MsgBox, Der Benutzer hat folgendes ausgewählt:`n%Quelle2%`n%Befehl2%

	FileCreateDir, %Befehl2%
	extensions = cmd;exe;bat;com
	Loop, parse, extensions,;
	{
	Loop,%Quelle2%\*.%A_LoopField%,0,1
   		FileCreateShortcut,%A_LoopFileFullPath%,%Befehl2%\%A_LoopFileName%.lnk, 0
	}
	return

ButtonEnde2:
	PostMessage, 0x0112, 0xF060,,, %AppName%  ; 0x0112 = WM_SYSCOMMAND, 0xF060 = SC_CLOSE
	return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs Dateimenü  MusterBax   [Version 004]                                                                │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Dateimenü: Datei ......................................

Beenden:
	GoSub,SavePosition
	return

Config:
	reload
	return

; Dateimenü: Einstellungen ..............................

00AppBar_Icon:
	Gui,Submit,NoHide
	IniRead, 00AppBar_Icon, %scriptini%, Schalter, 00AppBar_Icon
	00AppBar_Icon := 00AppBar_Icon

if (00AppBar_Icon = "0")
{
	Menu, Configmenü, Check, Toggle DesktopSymbol  
	FileCreateShortcut, %A_ScriptFullPath%, %A_Desktop%\%AppName%.lnk, %A_ScriptDir%, , BaxterWorks Software, %Bax_Icon%      
	IniWrite, 1, %scriptini%, Schalter, 00AppBar_Icon
}
if (00AppBar_Icon = "1")
{
    	Menu, Configmenü, UnCheck, Toggle DesktopSymbol  
	FileDelete, %A_Desktop%\%AppName%.lnk
	IniWrite, 0, %scriptini%, Schalter, 00AppBar_Icon
}
if (00AppBar_Icon = "ERROR")
{
    	Menu, Configmenü, UnCheck, Toggle DesktopSymbol
	FileDelete, %A_Desktop%\%AppName%.lnk
	IniWrite, 0, %scriptini%, Schalter, 00AppBar_Icon
	MsgBox, BaxterWorks meldet einen Fehler. Ist die ini-Datei ok? Wenn der Fehler bleibt`nbitte in der ini den Error mit 0 ersetzen.
}

return

;------------------------------------------------------------------------------------------

00AppBar_BaxBar:
	Gui,Submit,NoHide
	IniRead, 00AppBar_BaxBar, %scriptini%, Schalter, 00AppBar_BaxBar
	00AppBar_BaxBar := 00AppBar_BaxBar

if (00AppBar_BaxBar = "0")
{
	Menu, Configmenü, Check, Toggle BaxBarSymbol  
	FileCreateShortcut, %A_ScriptFullPath%, %Bax_Bar%\%AppName%.lnk, %A_ScriptDir%, , BaxterWorks Software, %Bax_Icon%      
	IniWrite, 1, %scriptini%, Schalter, 00AppBar_BaxBar
}
if (00AppBar_BaxBar = "1")
{
    	Menu, Configmenü, UnCheck, Toggle BaxBarSymbol
	FileDelete, %Bax_Bar%\%AppName%.lnk
	IniWrite, 0, %scriptini%, Schalter, 00AppBar_BaxBar
}
if (00AppBar_BaxBar = "ERROR")
{
    	Menu, Configmenü, UnCheck, Toggle BaxBarSymbol
	FileDelete, %Bax_Bar%\%AppName%.lnk
	IniWrite, 0, %scriptini%, Schalter, 00AppBar_BaxBar
	MsgBox, BaxterWorks meldet einen Fehler. Ist die ini-Datei ok? Wenn der Fehler bleibt`nbitte in der ini den Error mit 0 ersetzen.
}

return

;------------------------------------------------------------------------------------------

00AppBar_FensterInfo:
	Gui,Submit,NoHide
	IniRead, 00AppBar_FensterInfo, %scriptini%, Schalter, 00AppBar_FensterInfo
	00AppBar_FensterInfo := 00AppBar_FensterInfo

if (00AppBar_FensterInfo = "0")
{
	Menu, Configmenü, Check, Toggle FensterInfo  
	Bax_FensterInfo_Create()
	IniWrite, 1, %scriptini%, Schalter, 00AppBar_FensterInfo

}
if (00AppBar_FensterInfo = "1")
{
    	Menu, Configmenü, UnCheck, Toggle FensterInfo
	send, ^+8
	IniWrite, 0, %scriptini%, Schalter, 00AppBar_FensterInfo

}
if (00AppBar_FensterInfo = "ERROR")
{
    	Menu, Configmenü, UnCheck, Toggle FensterInfo
	send, ^+8
	IniWrite, 0, %scriptini%, Schalter, 00AppBar_FensterInfo
	MsgBox, BaxterWorks meldet einen Fehler. Ist die ini-Datei ok? Wenn der Fehler bleibt`nbitte in der ini den Error mit 0 ersetzen.
}

return

GetReady:
	run, %Bax_Start%\Apps\GetReadyBax\GetReadyBax.exe
	return

; Dateimnenü: Tools ....................................

DropperMenu:
	Bax_DropperGui_Create()
	return
Panik:
	AHKPanic(3)   ; 1 bis 3 - killt alle Skripte
	return

MenuIconShow:
	Bax_IconShow_Create()
	Return

MenuLinksEx:
	FileSelectFile, QuelleDatei, 3,, Wählen Sie eine Text- oder HTML-Datei zum Analysieren aus:
	if (QuelleDatei = "")
	return  ; In diesem Fall beenden.

	SplitPath, QuelleDatei,, QuelleDateiPfad,, QuelleDateiOhneEnd
	ZielDatei := QuelleDateiPfad "\" QuelleDateiOhneEnd " Extrahierte Links.txt"

	if FileExist(ZielDatei)
	{
	MsgBox, 4,, Vorhandene Datei überschreiben? Drücken Sie Nein, um die Links nur anzufügen.`n`nDATEI: %ZielDatei%
	IfMsgBox, Yes
        FileDelete, %ZielDatei%
	}

	LinksAnzahl := 0
	Loop, read, %QuelleDatei%, %ZielDatei%
	{
	URLSuchZkette := A_LoopReadLine
	Gosub, URLSuche
	}
	MsgBox %LinksAnzahl% Links wurden gefunden und in "%ZielDatei%" geschrieben.
	return
URLSuche:
	;Das wird auf diese Weise gemacht, weil einige URLs andere URLs eingebettet haben:
	URLStart1 := InStr(URLSuchZkette, "https://")
	URLStart2 := InStr(URLSuchZkette, "http://")
	URLStart3 := InStr(URLSuchZkette, "ftp://")
	URLStart4 := InStr(URLSuchZkette, "www.")

	; Findet die Startposition ganz links:
	URLStart := URLStart1  ; Setzt den Standardwert.
Loop
	{
	; Es kommt der Leistung zugute (zumindest in einem Skript mit vielen Variablen), wenn "URLStart%A_Index%" nur einmal aufgelöst wird:
	ArrayElement := URLStart%A_Index%
    	if (ArrayElement = "")  ; Ende des Pseudo-Arrays erreicht.
        break
    	if (ArrayElement = 0)  ; Dieses Element ist disqualifiziert.
        continue
    	if (URLStart = 0)
        	URLStart := ArrayElement
    	else 			; URLStart beinhaltet eine gültige Position, also mit ArrayElement vergleichen.
    	{
        if (ArrayElement != 0)
        if (ArrayElement < URLStart)
        	URLStart := ArrayElement
	}
	}

	if (URLStart = 0)  ; Keine URLs in der URLSuchZkette.
    	return

	; Extrahiert ansonsten diese URL:
	URL := SubStr(URLSuchZkette, URLStart)  ; Entfernt den beginnenden/irrelevanten Teil.
	Loop, parse, URL, %A_Tab%%A_Space%<>  ; Findet das erste Leer-, Tab- oder Winkelzeichen (falls vorhanden).
	{
   	URL := A_LoopField
    	break  ; Führt nur eine Schleifeniteration durch, um das erste "Feld" zu holen.
	}

	StringReplace, SaubereURL, URL, ",, All
	FileAppend, %SaubereURL%`n
	LinksAnzahl += 1

	; Schaut nach, ob noch andere URLs in dieser Zeile vorkommen:
	WegzulassendeZeichen := StrLen(URL)
	WegzulassendeZeichen += URLStart
	URLSuchZkette := SubStr(URLSuchZkette, WegzulassendeZeichen)
	Gosub, URLSuche  ; Rekursiver Aufruf von sich selbst.
	return

; Dateimnenü: BaxterWorks ..............................

Homepage:
	run, http://www.baxterworks.de/software
	return
HPTom:
	run, https://www.tombesch.de
	return
Blog:
	run, http://blog.baxterworks.de
	return
GitHub:
	run, https://github.com/T-Jah
	return

; Dateimnenü: Hilfe ....................................

Menucredits:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/credits.htm, %Bax_Start%\Files\credits.htm
	}
	run,%Bax_Start%\Files\credits.htm
	return

MenuHilfe:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/%Bax_help%.htm, %Bax_Start%\Files\%Bax_help%.htm
	}
	run,%Bax_Start%\Files\%Bax_help%.htm
	return

MenuInfo:
	run, %A_WinDir%\notepad.exe %Bax_Start%\Log\Versionsinfo_%AppName%.txt
	return

Lizenzmenu:
	Bax_LicenceGui_Create()
	return

MenuSupport:
	run, https://www.tombesch.de/konto.htm
	return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs Traymenü   MusterBax [Version 002]                                                                  │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

Licence:
	Bax_LicenceGui_Create()
	return

HilfeTray:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help.htm, %Bax_Start%\Files\help.htm
	}
	run,%Bax_Start%\Files\help.htm
	return

credits:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/credits.htm, %Bax_Start%\Files\credits.htm
	}
	run, %Bax_Start%\Files\credits.htm
	return

APPS:
	; Bax_ConfigGui_Create()
	return

EINSTELLUNGEN:
	Run,%scriptini%
	Return

Variablen:
	ListVars
	return

Version:
	Run,%Bax_Start%\Log\Versionsinfo_%AppName%.txt
	return
HotKeys:
	ListHotkeys
	return

Reload:
	reload
	return

OpenGUI:
	Gui, Show, Center Autosize, %AppName%
	return


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs Aboutfenster MusterBax       [Version 002]                                                          │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

BWApp:
  	Run,http://www.baxterworks.de/software/hilfe/%Bax_help%.htm,,UseErrorLevel
	Return

BWSoft:
 	Run,http://www.baxterworks.de/software,,UseErrorLevel
	Return

BWBlog:
  	Run,http://blog.baxterworks.de,,UseErrorLevel
	Return

AHKlabel:
  	Run,http://www.autohotkey.com,,UseErrorLevel
	Return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   EndSub  MusterBax        [Version 011]                                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

99GuiClose:
  	Gui,99:Destroy
 	OnMessage(0x200,"")
  	DllCall("DestroyCursor","Uint",hCur)
	Return

Suspend:
  	Suspend
	Return

EXIT:
quit:
GuiClose:
MenuEnde:
DateiBeenden:     		; Benutzer hat "Exit" im Dateimenü ausgewählt.
SavePosition:
ButtonCancel:			; falls es einen Button gibt
GuiEscape:
CleanUp:
	FormatTime, LastSeen,, LongDate
	IniWrite, %Lastseen% , %backuptxt%, Stats_%BaxNutzerName% , Lastseen
	IniWrite, %A_Now%_%AppName% , %backuptxt%, Stats_%BaxNutzerName% , LastLogIn
	IniWrite, %AppName%_%CodeVersion%_%Skriptvorlage%_%A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzung_%AppName%
	IniWrite, %A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzzeit_%AppName%
FileAppend, Nutzung: %A_Now% %A_Tab% Nutzer: %BaxNutzerName% %A_Tab% App: %AppName%_%CodeVersion% %A_Tab% Skriptvorlage: %Skriptvorlage% %A_Tab% %Appnutzcount% Starts in %Nutzungstage% Tagen`n , %Bax_Start%\Files\Stats\%A_ComputerName%.txt
	DetectHiddenWindows On
	WinGetPos, X, Y, %AppName%
	If (x > 0)
	IniWrite, % " x" X " y" Y, %scriptini%, Position, %AppName%_Position
 	IniWrite, 0, %scriptini%, Schalter, %AppName%_FensterInfo
	; SoundPlay, NoFile.wav
   	Gui, Destroy			; gibt die Ressource frei
	SoundBeep, 750, 500
  	CTLCOLORS.Free()		; wenn classCTLColours benutzt wurde
	Gdip_Shutdown(pToken)		; wird in includes gestartet

	if FileExist("..\..\Files\*.htm")
	FileDelete %Bax_Start%\Files\*.htm

ExitApp
