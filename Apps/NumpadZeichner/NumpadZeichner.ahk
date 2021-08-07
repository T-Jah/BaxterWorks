CodeVersion := "2.0.1.7", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\npz.ico
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription Rahmen und Kästen mit Numpad
;@Ahk2Exe-SetFileVersion 2.0.1.7
;@Ahk2Exe-SetProductVersion 2.0.1.7
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks NumpadZeichner
;@Ahk2Exe-SetProductName NumpadZeichner
; 
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
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 006               NumpadZeichner AHK Skript

/*
 * NumpadZeichner
 * Copyright 2021 T-Jah Tom
 * All Rights Reserved.
 * Use, reproduction, distribution, and modification of this code is subject to the terms and
 * conditions of the MIT license, available at http://www.opensource.org/licenses/mit-license.php
 *
 * Author: T-Jah Tom
 * Project: https://github.com/T-Jah
 *
 * ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * │   Skriptoptionen 	(lang)                 [Version 003]                                                    │
 * └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 *
 *                         BaxterWorks Software:	http://www.baxterworks.de/software
 *			                 http://blog.baxterworks.de
 *                                       ^ STRG + Shift ! Alt # WIN
 * 
 */

; Script options
	#SingleInstance force 			; oder off
	#NoEnv
	#MaxMem 512			
	#KeyHistory 500
	#Persistent
	#InstallKeybdHook
	#InstallMouseHook
		SetBatchLines -1
		DetectHiddenWindows On		; Ermöglicht die Erkennung des versteckten Hauptfensters eines Skripts.
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %A_ScriptDir%	; wichtig
		FileEncoding UTF-8
; Set Lock keys permanently - nur im ersten Skipt aufrufen (Tom)
	;SetNumlockState, AlwaysOn	
	;SetCapsLockState, AlwaysOff
	;SetScrollLockState, AlwaysOff

#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk

; Icon
Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\npz.ico	; #NoTrayIcon

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   FileInstall (Anfang AutoExecute)            [Version 004]                                                │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

FileInstall, ..\..\Grafix\ahk.ico, ..\..\Grafix\ahk.ico, 0						; 1 = überschreiben
FileInstall, ..\..\Grafix\bax.ico, ..\..\Grafix\bax.ico, 0						; 1 = überschreiben
FileInstall, ..\..\Grafix\BW_Software.ico, ..\..\Grafix\BW_Software.ico, 0				; 1 = überschreiben
FileInstall, ..\..\Grafix\npz.ico, ..\..\Grafix\npz.ico, 0						; 1 = überschreiben
FileInstall, ..\..\Config\NumpadZeichner.ini, ..\..\Config\NumpadZeichner.ini, 0			; 1 = überschreiben
FileInstall, ..\..\Log\Versionsinfo_NumpadZeichner.txt, ..\..\Log\Versionsinfo_NumpadZeichner.txt, 0	; 1 = überschreiben
FileInstall, ..\..\Files\Licence, ..\..\Files\Licence, 0						; 1 = überschreiben
FileInstall, ..\..\Files\help.md, ..\..\Files\help.md, 0						; 1 = überschreiben
FileInstall, ..\..\Files\Credits.md, ..\..\Files\Credits.md, 0					; 1 = überschreiben

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Variablen, zB Pfade     [Version 003]                                                                    │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Startumgebungsvariablen laden
	IniRead, Bax_Start , %A_ScriptDir%\..\..\Config\BaxterWorks.ini, FixVars, Bax_Start
	IniRead, homeini , %Bax_Start%\Config\BaxterWorks.ini, FixVars, homeini
	IniRead, userini , %Bax_Start%\Config\BaxterWorks.ini, FixVars, userini
	IniRead, Bax_Bar , %Bax_Start%\Config\BaxterWorks.ini, FixVars, Bax_Bar

; Startumgebungsvariablen festlegen
	AppName = NumpadZeichner
	LetzteAnmeldung = %A_UserName%
	LetzterEinsatz = %A_ComputerName%
	Bax_exe = %A_LineFile%
	Bax_Start = %Bax_Start%
	scriptini = %Bax_Start%\Config\%AppName%.ini
	Bax_Icon = %Bax_Start%\Grafix\npz.ico
	
; Variablentest
; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox,  %homeini% 


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   AppStart mit Subanweisung         [Version 001]                                                          │
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
; │   Includes (Ende Autoexec)        [Version 001]     +                                                      │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

#Persistent  							; Verhindert, dass sich das Skript automatisch beendet.
; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox, %Bax_ScriptStart%

	#Include %A_ScriptDir%\..\..\Function\BaxFunk_LicenceWindow.ahk	
 
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
return
;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Dateimenü, kein return        [Version 009]                                                         │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Fenster, Teil 1 [Version 015]                                                                       │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

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
Gui,99:Add,Text, R3 ,Tabellen oder Kästen und Rahmen auch in einfachen txt Dateien`nDas kann NumpadZeichner`nFunktioniert
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
; │   HotKeys     [Version 001]     +                                                                          │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


^n::
Run, notepad.exe
WinWaitActive, Unbenannt - Editor,, 2
if ErrorLevel
{
    MsgBox, WinWait hat das Zeitlimit überschritten.
    return
}
else
    WinMaximize ; Verwendet das von WinWaitActive gefundene Fenster.
SendInput {Raw}
(
__________                  __                __      __             __
\______   \_____  ___  ____/  |_  ___________/  \    /  \___________|  | __  ______
 |    |  _/\__  \ \  \/  /\   __\/ __ \_  __ \   \/\/   /  _ \_  __ \  |/ / /  ___/
 |    |   \ / __ \_>    <  |  | \  ___/|  | \/\        (  <_> )  | \/    <  \___ \
 |______  /(____  /__/\_ \ |__|  \___  >__|    \__/\  / \____/|__|  |__|_ \/____  >
        \/      \/      \/           \/             \/                   \/     \/
------------------------------------------------------------------------------------
                                                            (c) 1999-2021 T-Jah Tom

)

return

Numpad1::SendInput {Raw}└
Numpad2::SendInput {Raw}─
Numpad3::SendInput {Raw}┘
Numpad4::SendInput {Raw}┌
Numpad5::SendInput {Raw}│
Numpad6::SendInput {Raw}┐
Numpad7::SendInput {Raw}┤
Numpad8::SendInput {Raw}┼
Numpad9::SendInput {Raw}├
Numpad0::SendInput {Raw}┬
NumpadDot::SendInput {Raw}┴
NumpadEnter::SendInput {Raw}╧
NumpadMult::SendInput {Raw}╤
NumpadDiv::SendInput {Raw}╘══╛
NumpadAdd::SendInput {Raw}╒══╕
NumpadSub::SendInput {Raw}╞══╡

^Numpad1::SendInput {Raw}╚
^Numpad2::SendInput {Raw}═
^Numpad3::SendInput {Raw}╝
^Numpad4::SendInput {Raw}╔
^Numpad5::SendInput {Raw}║
^Numpad6::SendInput {Raw}╗
^Numpad7::SendInput {Raw}╙──╜
^Numpad8::SendInput {Raw}╬═╪═
^Numpad9::SendInput {Raw}╓──╖
^Numpad0::SendInput {Raw}█
^NumpadDot::SendInput {Raw}░
^NumpadEnter::SendInput {Raw}╠══╣
^NumpadMult::SendInput {Raw}╦╩
^NumpadDiv::SendInput {Raw}╫
^NumpadAdd::SendInput {Raw}■□
^NumpadSub::SendInput {Raw}▀▄

^+1::SendInput {Raw}╔══╦══╗
^+2::SendInput {Raw}╠══╬══╣
^+3::SendInput {Raw}╚══╩══╝

^+4::SendInput {Raw}┌──┬──┐
^+5::SendInput {Raw}├──┼──┤
^+6::SendInput {Raw}└──┴──┘

^+7::SendInput {Raw}╒══╦╤══╕
^+8::SendInput {Raw}╞══╬╪══╡
^+9::SendInput {Raw}╘══╩╧══╛


^+0::SendInput {Raw}
(
  ╒══════════════════════════════════════════════════════════════╕
  │                  Tabellen für Textdateien   	         │
  ├──────────────────────────────────────────────────────────────┤
  │         						         │
  ╞══════════════════════════════════════════════════════════════╡
  │ Feld  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │
  ├─────────┬─────────┬──────────────────────────────────────────┤
  │         │         │ 	                                 │
  ├─────────┼─────────┼──────────────────────────────────────────┤
  │         │ 	      │ 				         │
  ├─────────┼─────────┼──────────────────────────────────────────┤
  │   	    │ 	      │ 				         │
  ├─────────┼─────────┼──────────────────────────────────────────┤
  │         │         │                                          │
  │ 	    ├─────────┼──────────────────────────────────────────┤
  │         │ 	      │ 			                 │
  ├─────────┼─────────┼──────────────────────────────────────────┤
  │ 	    │ 	      │ 					 │
  │ 	    ├─────────┼──────────────────────────────────────────┤
  │         │  	      │ 					 │
  ├─────────┼─────────┼──────────────────────────────────────────┤
  │ 	    │ 	      │ 					 │
  │ 	    ├─────────┼──────────────────────────────────────────┤
  │         │ 	      │ 					 │
  │         ├─────────┼──────────────────────────────────────────┤
  │         │ 	      │ 					 │
  │         ├─────────┼──────────────────────────────────────────┤
  │         │ 	      │ 					 │
  ├─────────┼─────────┼──────────────────────────────────────────┤
  │         │ 	      │ 					 │
  ├─────────┼─────────┼──────────────────────────────────────────┤
  │ 	    │ 	      │ 					 │
  ╞═════════╧═════════╧══════════════════════════════════════════╡
  │ Feld  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │
  ├──────────┬───────────────────────────────────────────────────┤
  │ 	     │ 			                                 │
  ├──────────┼───────────────────────────────────────────────────┤
  │ 	     │ 				                         │
  ├──────────┼───────────────────────────────────────────────────┤
  │          │ 					                 │
  ├──────────┼───────────────────────────────────────────────────┤
  │ 	     │ 						         │
  ├──────────┼───────────────────────────────────────────────────┤
  │ 	     │						         │
  ╞══════════╧═══════════════════════════════════════════════════╡
  │ Feld  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │
  ├──────────────────────────────────────────────────────────────┤
  │								 │
  │      						         │
  │      							 │
  │      					                 │
  │                 					         │
  ╞══════════════════════════════════════════════════════════════╡
  │              © 2021 BaxterWorks, T-Jah Tom                   │
  ╘══════════════════════════════════════════════════════════════╛
)
return


#IfWinActive
; ---------------------------------------------------------------------------------->
; ---------------------------------------------------------------------------------->

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Funktionen                                                                                               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Label und Subs    [Version 005]                                                                                    │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
; Hinweis: sub sonstiges ist nicht Standard


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Sub sonstiges                                                                                            │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Sub Ini  [Version 003]                                                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

INIDELETE:
	IniDelete, %scriptini%, Nutzerinfo, 

INIREAD:
	IniRead, Bax_IP , %homeini%, Netzinfo, Letzte IP, %A_Space%
	IniRead, Ziel1, %userini%, Dropper, Ziel1, %A_Space% 
	IniRead, Ziel2, %userini%, Dropper, Ziel2, %A_Space% 
	IniRead, DeinOrdner1, %userini%, 2Win, DeinOrdner1, %A_Space% 
	IniRead, DeinOrdner2, %userini%, 2Win, DeinOrdner2, %A_Space% 
	IniRead, Bax_JobDir, %userini%, Variablen, Bax_JobDir, %A_Space% 
	IniRead, Bax_Flex, %userini%, Variablen, Bax_Flex, %A_Space% 


INIWRITE:
	IniWrite, %LetzteAnmeldung% , %scriptini%, Nutzerinfo, Letzter Nutzer
	IniWrite, %LetzterEinsatz% , %scriptini%, Nutzerinfo, Letzter Rechner
	IniWrite, %Bax_IP% , %scriptini%, Nutzerinfo, Letzte IP
	IniWrite, %Bax_exe% , %scriptini%, Skriptinfo, Bax_exe

return



; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs GUI-Fenster       [Version 006]                                                                     │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs Traymenü      (nicht Standard)                                                                      │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

Anleitung:
Run,%A_ScriptDir%\data\Hilfe_NumpadZeichner.txt
return

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
	GoSub, About
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
; │   EndSub          [Version 001]                                                                            │
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
ButtonCancel:			; falls es einen Button gibt
GuiEscape:
CleanUp:
	SoundBeep, 750, 500
  	CTLCOLORS.Free()		; wenn classCTLColours benutzt wurde
	;Gdip_Shutdown(pToken)		; wird in includes gestartet

	if FileExist("..\..\Files\*.htm")
	FileDelete %Bax_Start%\Files\*.htm

ExitApp
