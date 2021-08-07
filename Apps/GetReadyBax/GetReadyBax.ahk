CodeVersion := "1.0.0.6", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\runaway.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription GetReadyBax - BaxterWorks Konfiguration
;@Ahk2Exe-SetFileVersion 1.0.0.6
;@Ahk2Exe-SetProductVersion 1.0.0.6
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks GetReadyBax
;@Ahk2Exe-SetProductName GetReadyBax
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
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 010               MusterBax AHK Skript

/*
 * GetReadyBax
 * Copyright 2021 T-Jah Tom
 * All Rights Reserved.
 * Use, reproduction, distribution, and modification of this code is subject to the terms and
 * conditions of the MIT license, available at http://www.opensource.org/licenses/mit-license.php
 *
 * Author: T-Jah Tom
 * Project: https://github.com/T-Jah
 *
 * ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * │   Skriptoptionen 	(lang)                 [Version 005]                                                    │
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
	Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\runaway.ico	; #NoTrayIcon
	
; OnExit
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk

; beende BW, starte BW beim beenden neu
Process, Close, BaxterWorks.exe
;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Variablen, zB Pfade     [Version 005]                                                                    │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Startumgebungsvariablen laden
	IniRead, Bax_Start , %A_ScriptDir%\..\..\Config\BaxterWorks.ini, FixVars, Bax_Start
	IniRead, homeini , %Bax_Start%\Config\BaxterWorks.ini, FixVars, homeini
	IniRead, userini , %homeini%, FixVars, userini
	IniRead, Bax_Bar , %homeini%, FixVars, Bax_Bar
	IniRead, Bax_exe , %homeini%, FixVars, Bax_exe
	IniRead, backuptxt , %homeini%, FixVars, backuptxt

; Startumgebungsvariablen festlegen
	AppName = GetReadyBax
	LetzteAnmeldung = %A_UserName%
	LetzterEinsatz = %A_ComputerName%
	BaxNutzerName = %A_UserName%_%A_ComputerName%
	Bax_Start = %Bax_Start%
	scriptini = %Bax_Start%\Config\%AppName%.ini
	Bax_Icon = %Bax_Start%\Grafix\runaway.ico
	Bax_help = help_getreadybax
	
; Variablentest
; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox,  %homeini% 

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   AppStart mit Subanweisung         [Version 002]                                                          │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

/** IP Logbuch, archiviert die eigene externe IP
	URLDownloadToFile,http://www.netikus.net/show_ip.html, %A_ScriptDir%\..\..\Files\IP Logbuch\showip_%A_YYYY%_%A_MM%_%A_DD%.txt
	if ErrorLevel = 1
  	{
    	MsgBox, 16,IpAddresses,Your public Ipaddress could not be detected.
  	}
	FileReadLINE,BaxIP,%A_ScriptDir%\..\..\Files\IP Logbuch\showip_%A_YYYY%_%A_MM%_%A_DD%.txt, 1
	IniWrite, %BaxIP% , %scriptini%, Netzinfo, Letzte IP

Hinweis: Standardmäßig deaktiviert, sollte nur in einem Skript verwendet werden, das regelmäßig läuft
*/

;---------------------------------------------------------------->
; AppStart (AutoExec Bereich geht nach dem letzten Eintrag weiter)
; Also hier nach Traymenü.
;---------------------------------------------------------------->

	GoSub,INIDELETE
	GoSub,INIREAD
	GoSub,INIWRITE
	GoSub,TRAYMENU


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Includes (Ende Autoexec)        [Version 006]                                                            │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

#Persistent  							; Verhindert, dass sich das Skript automatisch beendet.
; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox, %Bax_ScriptStart%

; BaxFunk Module
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_FensterInfo.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_IconShow.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_LicenceWindow.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_2Win.ahk
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Dropper.ahk
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_ConfigWindow.ahk
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_reloadAHK.ahk
	#Include %A_ScriptDir%\..\..\Lib\datecalc.ahk
	#include %A_ScriptDir%\..\..\Lib\funk_panic.ahk
	#Include %A_ScriptDir%\..\..\Lib\funk_toggle.ahk
	#Include %A_ScriptDir%\..\..\Lib\Gdip_all.ahk
	#Include %A_ScriptDir%\..\..\Lib\ipfindmap.ahk
	#Include %A_ScriptDir%\..\..\Lib\keepalive.ahk
	#Include %A_ScriptDir%\..\..\Lib\MouseisOver.ahk
	#Include %A_ScriptDir%\..\..\Lib\ObjCSV.ahk
	#Include %A_ScriptDir%\..\..\Lib\tf.ahk
	#Include %A_ScriptDir%\..\..\Lib\toggle_hiddenfiles.ahk
	#Include %A_ScriptDir%\..\..\Lib\toggle_lightdark.ahk


	Gdip_Startup()
	
;-------------------------------------------------------Ende AutoExec
	return
;-------------------------------------------------------Ende AutoExec


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Traymenü                    [Version 001]                                                           │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

TRAYMENU:
Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray,NoMainWindow
Menu,Tray,Add,%AppName%,OpenGUI
Menu,Tray,Add						; Trennlinie
Menu,Tray,Add,&Licence...,Licence
Menu,Tray,Add,&Credits...,Credits
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
; │   GUI, Dateimenü, kein return        [Version 003]                                                         │
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

Menu, Hilfsmenü, Add, Credits, MenuCredits
Menu, Hilfsmenü, Icon, Credits, C:\WINDOWS\System32\SHELL32.dll,131
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
; │   GUI, Fenster, Teil 1 [Version 001]                                                                       │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

Gui, Font, s10 cWhite, Verdana,Tahoma
Gui, Margin, 0, 10
Gui, Color, White

	IniRead, Pos, %scriptini%, Position, %AppName%_Position
	If (Pos = "ERROR") {
	IniWrite, x40 y40, %scriptini%, Position, %AppName%_Position
	Gui, Show, x40 y40, GetReadyBax Error
	}
	Else

; -------------------------------------------------------------------------------------------
	IniRead, %AppName%_Icon, %scriptini%, Schalter, %AppName%_Icon

	If (GetReadyBax_Icon = "1") {
	Menu, Configmenü, Check, 1&
	}
	If (GetReadyBax_Icon = "0") {
	Menu, Configmenü, UnCheck, 1&
	}

; -------------------------------------------------------------------------------------------

	IniRead, %AppName%_BaxBar, %scriptini%, Schalter, %AppName%_BaxBar

	If (GetReadyBax_BaxBar = "1") {
	Menu, Configmenü, Check, 2&
	}
	If (GetReadyBax_BaxBar = "0") {
	Menu, Configmenü, UnCheck, 2&
	}

; -------------------------------------------------------------------------------------------

IniRead, %AppName%_FensterInfo, %scriptini%, Schalter, %AppName%_FensterInfo

If (GetReadyBax_FensterInfo = "1"){
Menu, Configmenü, Check, 3&
}

If (GetReadyBax_FensterInfo = "0"){
Menu, Configmenü, UnCheck, 3&
}

; -------------------------------------------------------------------------------------------

Gui,Menu, MeineMenüleiste
Gui, Font
Gui, Font, s12 cBlack, Verdana,Tahoma
Gui,Add,Picture, x-1 y0 w600 h-1, ..\..\Grafix\bw_banner.png

	IniRead, GetReadyBax_AOTStatus, %scriptini%, Schalter, GetReadyBax_AOTStatus
	If (GetReadyBax_AOTStatus = "1") {
	Gui,+AlwaysOnTop
	}
	IniRead, GetReadyBax_AOT, %scriptini%, Schalter, GetReadyBax_AOT
	If (GetReadyBax_AOT = "-") {
	WinSet, AlwaysOnTop, Off
	}
	else 
	GetReadyBax_AOT := +
	WinSet, AlwaysOnTop, On

Gui, Add, CheckBox, x5 y+5 vGetReadyBax_AOTStatus gAOTLabel Checked%GetReadyBax_AOT%, Always on top
Gui, Font

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Fenster, Teil 2 [ohne Versionsnummer]                                                               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;
FileEncoding UTF-8
Gui, Font, s10 cBlack, Verdana,Tahoma
Gui, add, Groupbox, w440 h100 x600 y0,GetReadyBax - Konfiguration
Gui, Font
Gui, Font, s12 cBlack, Verdana,Tahoma
Gui,Add,Text, x620 y25 R2, Wähle die Pfade mit dem SELECT Button.`nOhne die Eingabe kann es zu Fehlern kommen.
Gui, Font

Gui, Font, s9 cBlack, Tahoma,Verdana

IniRead, Ziel1 , %userini% , Dropper , Ziel1 , %A_Space%
Gui, Add, Text, x20 y150 w160 h20 , Dropper-Fenster - Ziel 1
Gui, Add, Edit, x190 y150 w630 h20 vZiel1, %Ziel1%
GuiControlGet, Ziel1
Gui, Add, Button, x830 y150 w110 h20 gOrdnerwahl1 , Select
Gui, Add, Button, x950 y150 w70 h20 gInfoknopf1, Info

IniRead, Ziel2 , %userini%, Dropper, Ziel2, %A_Space%
Gui, Add, Text, x20 y170 w160 h20 , Dropper-Fenster - Ziel 2
Gui, Add, Edit, x190 y170 w630 h20 vZiel2, %Ziel2%
GuiControlGet, Ziel2
Gui, Add, Button, x830 y170 w110 h20 gOrdnerwahl2 , Select
Gui, Add, Button, x950 y170 w70 h20 gInfoknopf1, Info

IniRead, DeinOrdner1 , %userini%, 2Win, DeinOrdner1 , %A_Space% 
Gui, Add, Text, x20 y190 w160 h20 , 2Win-Ordner Nr.1
Gui, Add, Edit, x190 y190 w630 h20 vDeinOrdner1, %DeinOrdner1%
GuiControlGet, DeinOrdner1
Gui, Add, Button, x830 y190 w110 h20 gOrdnerwahl3 , Select
Gui, Add, Button, x950 y190 w70 h20 gInfoknopf3, Info

IniRead, DeinOrdner2 , %userini%, 2Win, DeinOrdner2 , %A_Space%
Gui, Add, Text, x20 y210 w160 h20 , 2Win-Ordner Nr.2
Gui, Add, Edit, x190 y210 w630 h20 vDeinOrdner2, %DeinOrdner2%
GuiControlGet, DeinOrdner2
Gui, Add, Button, x830 y210 w110 h20 gOrdnerwahl4 , Select
Gui, Add, Button, x950 y210 w70 h20 gInfoknopf3, Info

IniRead, Bax_JobDir , %userini%, Variablen, Bax_JobDir , %A_Space%
Gui, Add, Text, x20 y240 w160 h20 , Variable Bax_JobDir
Gui, Add, Edit, x190 y240 w630 h20 vBax_JobDir, %Bax_JobDir%
GuiControlGet, Bax_JobDir
Gui, Add, Button, x830 y240 w110 h20 gOrdnerwahl5 , Select
Gui, Add, Button, x950 y240 w70 h20 gInfoknopf5, Info

IniRead, Bax_Flex , %userini%, Variablen, Bax_Flex , %A_Space%
Gui, Add, Text, x20 y260 w160 h20 , Variable Bax_Flex
Gui, Add, Edit, x190 y260 w630 h20 vBax_Flex, %Bax_Flex%
GuiControlGet, Bax_Flex
Gui, Add, Button, x830 y260 w110 h20 gOrdnerwahl6 , Select
Gui, Add, Button, x950 y260 w70 h20 gInfoknopf6 , Info

Gui, Add, Button, x20 y+20 gButtonSpeichern ,&speichern
Gui, Add, Button, x+2 gButtonBeenden ,speichern und &beenden
Gui, Add, Button, x+2 gButtonCancel ,&abbrechen

Gui, Font
Gui, Show, %Pos% w1070, %AppName%
OnMessage(0x200, "CheckControl")
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, TrayFensterFenster (About), ein Label vom Traymenü      [Version 001]                               │
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
Gui,99:Add,Text, R3 ,Gibt dem Nutzer die Möglichkeit der Personalisierung.`nVariablen speichern. Das ist die Aufgabe von GetReadyBax`nFunktioniert.
Gui,99:Font,cBlue bold Underline
Gui,99:Add,Text,R1 gBWApp,www.baxterworks.de/software
Gui,99:Font

Gui,99:Add,Picture,xs w70 h70 Icon1,%Bax_Start%\Grafix\BW_Software.ico
Gui,99:Font,Bold
Gui,99:Font, s10 cBlack, Verdana
Gui,99:Add,Text, R1 xp+100 ,%Firma%
Gui,99:Font
Gui,99:Font, s9 cBlack, Verdana
Gui,99:Add,Text,R3 ,Auf der Webseite findest du weitere Apps,`nein paar Codeschnippsel und Informationen`nzur Software.
Gui,99:Font,CBlue bold Underline
Gui,99:Add,Text,y+5 gBWSoft,www.baxterworks.de/software
Gui,99:Font

Gui,99:Add,Picture,xs w70 h70 Icon1,%Bax_Start%\Grafix\bax.ico
Gui,99:Font,Bold
Gui,99:Font, s10 cBlack, Verdana
Gui,99:Add,Text, R1 xp+100 ,Blog BaxterWorks
Gui,99:Font
Gui,99:Font, s9 cBlack, Verdana
Gui,99:Add,Text,R3 ,Die ungefragte Meinung`nIn unregelmäßigen Abständen melde ich mich dort zu Wort.`nMöglichkeit der Kontaktaufnahme ist gegeben.
Gui,99:Font,CBlue bold Underline
Gui,99:Add,Text,y+5 gBWBlog,blog.baxterworks.de
Gui,99:Font

Gui,99:Add,Picture,xs w70 h70 Icon1,%Bax_Start%\Grafix\ahk.ico
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
; │   HotKeys     [Version 001]                                                                                │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;




; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Funktionen Standard [Version 002]                                                                        │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Tooltips für die GUI

CheckControl() {
MouseGetPos,,,, VarControl
IfEqual, VarControl, Button1
	Message := "An oder Aus - entscheide dich"
else IfEqual, VarControl, Button2
	Message := "Du kannst deine Angaben jederzeit ändern"
else IfEqual, VarControl, Button3
	Message := "Bitte zuerst einen Zielordner wählen."
else IfEqual, VarControl, Button4
	Message := "Kurze Info zum Dropper-Fenster"
else IfEqual, VarControl, Button7
	Message := "Bitte zuerst einen Zielordner wählen."
else IfEqual, VarControl, Button8
	Message := "Kurze Info zur Funktion 2Win"
else IfEqual, VarControl, Button11
	Message := "Bitte zuerst einen Zielordner wählen."
else IfEqual, VarControl, Button12
	Message := "Kurze Info zur Variablen Bax_JobDir"
else IfEqual, VarControl, Button13
	Message := "Bitte zuerst einen Zielordner wählen."
else IfEqual, VarControl, Button14
	Message := "Kurze Info zur Variablen Bax_Flex"
else IfEqual, VarControl, Button15
	Message := "Eingaben speichern."
else IfEqual, VarControl, Button16
	Message := "Eingaben speichern und App beenden"
else IfEqual, VarControl, Button17
	Message := "Beenden und später fortsetzen"
ToolTip % Message
}

;--------------------------------------------------------

; Dropfiles GUI

GuiDropFiles(GuiHwnd, DateiArray, ElementHwnd, X, Y) {
	for i, Datei in DateiArray
		MsgBox Datei %i% ist:`n%Datei%`n`nKeine Ahnung, was ich jetzt damit machen soll.
}
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Funktionen von diesem Skript                                                                             │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;
;---------------------------------------------------------------------------- Ordnerwahl

Ordnerwahl1:
FileSelectFolder, Ziel1,Ziel1 , 3
if Ziel1 =
    MsgBox, Keinen Ordner ausgewählt.
else
    GuiControl,, Ziel1, %Ziel1%
return

Ordnerwahl2:
FileSelectFolder, Ziel2,Ziel2 , 3
if Ziel2 =
    MsgBox, Keinen Ordner ausgewählt.
else
    GuiControl,, Ziel2, %Ziel2%
return

Infoknopf1:
MsgBox, Die Funktion Dropperfenster benötigt zwei Ordnerangaben.`nEmpfohlen ist ein Ordner für neue Downloads`nund ein Ordner für Texte`n
return
;--------------- 


Ordnerwahl3:
FileSelectFolder, DeinOrdner1,DeinOrdner1 , 3
if DeinOrdner1 =
    MsgBox, Keinen Ordner ausgewählt.
else
    GuiControl,, DeinOrdner1, %DeinOrdner1%
return

Ordnerwahl4:
FileSelectFolder, DeinOrdner2,DeinOrdner2 , 3
if DeinOrdner2 =
    MsgBox, Keinen Ordner ausgewählt.
else
    GuiControl,, DeinOrdner2, %DeinOrdner2%
return

Infoknopf3:
MsgBox, Die Funktion 2Win öffnet 2 Explorerfenster nebeneinander.`nWähle zwei Ordnerpfade die du häufig benutzen musst`nwährend du deine Aufgaben am PC erledigst`n
return
;--------------- 

Ordnerwahl5:
FileSelectFolder, Bax_JobDir,Bax_JobDir , 3
if Bax_JobDir =
    MsgBox, Keinen Ordner ausgewählt.
else
    GuiControl,, Bax_JobDir, %Bax_JobDir%
return

Ordnerwahl6:
FileSelectFile, Bax_Flex, 3, , beliebige Datei wählen (*.*)
if Bax_Flex =
    MsgBox, Keine Datei ausgewählt.
else
    GuiControl,, Bax_Flex, %Bax_Flex%
return

Infoknopf5:
MsgBox, Die Variable Bax_JobDir steht für einen Ordner mit ToDo-Listen und`nanderen noch zu erledigende Dingen. Du kannst`ndie Ordner natürlich auch anders füllen
return

Infoknopf6:
MsgBox, Hast du selber Skripte im Einsatz?`nMit dieser Variablen kannst du auf eine beliebige Datei zeigen`nund in BaxterWorks einbauen. Das kann ein Programm sein und auch eine Internet-Adresse. Mit dem HotKey STRG+SHIFT+0 kannst du die Ressource starten
return

;--------------- 

;---------------------------------------------------------------------------- Speichern
ButtonSpeichern:
Gui,Submit,NoHide
	IniWrite, %Ziel1% , %userini%, Dropper, Ziel1
	IniWrite, %Ziel2% , %userini%, Dropper, Ziel2
	IniWrite, %DeinOrdner1% , %userini%, 2Win, DeinOrdner1
	IniWrite, %DeinOrdner2% , %userini%, 2Win, DeinOrdner2
	IniWrite, %Bax_JobDir% , %userini%, Variablen, Bax_JobDir
	IniWrite, %Bax_Flex% , %userini%, Variablen, Bax_Flex
	IniWrite, %LetzteAnmeldung% , %userini%, Nutzerinfo, Letzter Nutzer
	IniWrite, %LetzterEinsatz% , %userini%, Nutzerinfo, Letzter Rechner
return

ButtonBeenden:
Gui,Submit,NoHide
	IniWrite, %Ziel1% , %userini%, Dropper, Ziel1
	IniWrite, %Ziel2% , %userini%, Dropper, Ziel2
	IniWrite, %DeinOrdner1% , %userini%, 2Win, DeinOrdner1
	IniWrite, %DeinOrdner2% , %userini%, 2Win, DeinOrdner2
	IniWrite, %Bax_JobDir% , %userini%, Variablen, Bax_JobDir
	IniWrite, %Bax_Flex% , %userini%, Variablen, Bax_Flex
	IniWrite, %LetzteAnmeldung% , %userini%, Nutzerinfo, Letzter Nutzer
	IniWrite, %LetzterEinsatz% , %userini%, Nutzerinfo, Letzter Rechner

GoSub,Finisher
; noch vor der EndSub
return

ButtonCancel:
	IniWrite, %LetzteAnmeldung% , %userini%, Nutzerinfo, Letzter Nutzer
	IniWrite, %LetzterEinsatz% , %userini%, Nutzerinfo, Letzter Rechner
Winclose

run, %Bax_Start%\BaxterWorks.exe
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Label und Subs    [Version 005]                                                                          │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
; 


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Sub sonstiges                                                                                            │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;



;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Sub Ini  [Version 004]    + muss nicht alle Vars laden, die im Skript gesetzt werden                     │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

INIDELETE:
	IniDelete, %scriptini%, Nutzerinfo, 

INIREAD:
	IniRead, Bax_IP , %homeini%, Netzinfo, Letzte IP

INIWRITE:
	IniWrite, %LetzteAnmeldung% , %scriptini%, Nutzerinfo, Letzter Nutzer
	IniWrite, %LetzterEinsatz% , %scriptini%, Nutzerinfo, Letzter Rechner
	IniWrite, %Bax_IP% , %scriptini%, Nutzerinfo, Letzte IP
	IniWrite, %Bax_exe% , %scriptini%, Skriptinfo, Bax_exe

return


;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs GUI-Fenster       [Version 001]                                                                     │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Always on Top Toggle, gehört zur Checkbox in der GUI, sofern vorhanden.

AOTLabel:
	Gui,Submit,NoHide
	IniWrite, %GetReadyBax_AOTStatus%, %scriptini%, Schalter, GetReadyBax_AOTStatus

; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox, %GetReadyBax_AOTStatus%  ; sollte 0 oder 1 sein

	if (GetReadyBax_AOTStatus=1)
	{
	WinSet, AlwaysOnTop, On
	IniWrite, + , %scriptini%, Schalter, GetReadyBax_AOT
	}
	else
	{
	WinSet, AlwaysOnTop, Off
	IniWrite, - , %scriptini%, Schalter, GetReadyBax_AOT
	}
	Return


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs Dateimenü     [Version 003]                                                                         │
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

GetReadyBax_Icon:
	Gui,Submit,NoHide
	IniRead, GetReadyBax_Icon, %scriptini%, Schalter, GetReadyBax_Icon
	GetReadyBax_Icon := GetReadyBax_Icon

; --------------------------------------------------------------- TextBox für die Fehlersuche
;MsgBox, jetzt %GetReadyBax_Icon%

if (GetReadyBax_Icon = "0")
{
	Menu, Configmenü, Check, Toggle DesktopSymbol  
	FileCreateShortcut, %Bax_exe%, %A_Desktop%\%AppName%.lnk, %A_ScriptDir%, "%A_ScriptFullPath%", BaxterWorks Software mit STRG+Alt+M starten, %Bax_Start%\Grafix\runaway.ico, M      
	IniWrite, 1, %scriptini%, Schalter, GetReadyBax_Icon
}
if (GetReadyBax_Icon = "1")
{
    	Menu, Configmenü, UnCheck, Toggle DesktopSymbol  
	FileDelete, %A_Desktop%\%AppName%.lnk
	IniWrite, 0, %scriptini%, Schalter, GetReadyBax_Icon
}
if (GetReadyBax_Icon = "ERROR")
{
    	Menu, Configmenü, UnCheck, Toggle DesktopSymbol
	FileDelete, %A_Desktop%\%AppName%.lnk
	IniWrite, 0, %scriptini%, Schalter, GetReadyBax_Icon
	MsgBox, BaxterWorks meldet einen Fehler. Ist die ini-Datei ok? Wenn der Fehler bleibt`nbitte in der ini den Error mit 0 ersetzen.
}

return

GetReadyBax_BaxBar:
	Gui,Submit,NoHide
	IniRead, GetReadyBax_BaxBar, %scriptini%, Schalter, GetReadyBax_BaxBar
	GetReadyBax_BaxBar := GetReadyBax_BaxBar

; --------------------------------------------------------------- TextBox für die Fehlersuche
;MsgBox, jetzt %GetReadyBax_BaxBar%

if (GetReadyBax_BaxBar = "0")
{
	Menu, Configmenü, Check, Toggle BaxBarSymbol  
	FileCreateShortcut, %Bax_exe%, %Bax_Bar%\%AppName%.lnk, %A_ScriptDir%, "%A_ScriptFullPath%", BaxterWorks Software, %Bax_Start%\Grafix\runaway.ico,      
	IniWrite, 1, %scriptini%, Schalter, GetReadyBax_BaxBar
}
if (GetReadyBax_BaxBar = "1")
{
    	Menu, Configmenü, UnCheck, Toggle BaxBarSymbol
	FileDelete, %Bax_Bar%\%AppName%.lnk
	IniWrite, 0, %scriptini%, Schalter, GetReadyBax_BaxBar
}
if (GetReadyBax_BaxBar = "ERROR")
{
    	Menu, Configmenü, UnCheck, Toggle BaxBarSymbol
	FileDelete, %Bax_Bar%\%AppName%.lnk
	IniWrite, 0, %scriptini%, Schalter, GetReadyBax_BaxBar
	MsgBox, BaxterWorks meldet einen Fehler. Ist die ini-Datei ok? Wenn der Fehler bleibt`nbitte in der ini den Error mit 0 ersetzen.
}

return

GetReadyBax_FensterInfo:
	Gui,Submit,NoHide
	IniRead, GetReadyBax_FensterInfo, %scriptini%, Schalter, GetReadyBax_FensterInfo
	GetReadyBax_FensterInfo := GetReadyBax_FensterInfo

; --------------------------------------------------------------- TextBox für die Fehlersuche
;MsgBox, jetzt %GetReadyBax_FensterInfo%

if (GetReadyBax_FensterInfo = "0")
{
	Menu, Configmenü, Check, Toggle FensterInfo  
	Bax_FensterInfo_Create()
	IniWrite, 1, %scriptini%, Schalter, GetReadyBax_FensterInfo
}
if (GetReadyBax_FensterInfo = "1")
{
    	Menu, Configmenü, UnCheck, Toggle FensterInfo
	send, ^+8
	IniWrite, 0, %scriptini%, Schalter, GetReadyBax_FensterInfo
}
if (GetReadyBax_FensterInfo = "ERROR")
{
    	Menu, Configmenü, UnCheck, Toggle FensterInfo
	send, ^+8
	IniWrite, 0, %scriptini%, Schalter, GetReadyBax_FensterInfo
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

MenuCredits:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/Credits.htm, %Bax_Start%\Files\Credits.htm
	}
	run,%Bax_Start%\Files\Credits.htm
	return

MenuHilfe:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/%Bax_help%.htm, %Bax_Start%\Files\%Bax_help%.htm
	}
	run,%Bax_Start%\Files\%Bax_help%.htm
	return

MenuInfo:
	run, %A_WinDir%\notepad.exe %Bax_Start%\ChangeLog\Versionsinfo_%AppName%.txt
	return

Lizenzmenu:
	Bax_LicenceGui_Create()
	return

MenuSupport:
	run, https://www.tombesch.de/konto.htm
	return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs Traymenü    [Version 002]                                                                           │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

Licence:
	Bax_LicenceGui_Create()
	return

HilfeTray:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/%Bax_help%.htm, %Bax_Start%\Files\%Bax_help%.htm
	}
	run,%Bax_Start%\Files\%Bax_help%.htm
	return

Credits:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/Credits.htm, %Bax_Start%\Files\Credits.htm
	}
	run, %Bax_Start%\Files\Credits.htm
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
; │   Subs Aboutfenster        [Version 001]                                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

BWApp:
  	Run,http://www.baxterworks.de/software/hilfe/help.htm,,UseErrorLevel
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
; │   EndSub special  [Version 001]     + nur dieses Skript                                                    │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;
Finisher:
if !WinExist("ahk_exe BaxterWorks.exe")	
	Run, %Bax_Start%\BaxterWorks.exe
GoSub,Exit

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   EndSub          [Version 003]                                                                            │
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
	;IniWrite, %Lastseen%_%BaxNutzerName% , %backuptxt%, %BaxNutzerName% , Lastseen
;ButtonCancel:			; falls es einen Button gibt
GuiEscape:
CleanUp:
SavePosition:
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


if !WinExist("ahk_exe BaxterWorks.exe")	
	Run, %Bax_Start%\BaxterWorks.exe
ExitApp
