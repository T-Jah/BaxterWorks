CodeVersion := "2.0.1.9", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\npz.ico
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription Rahmen und Kästen mit Numpad
;@Ahk2Exe-SetFileVersion 2.0.1.9
;@Ahk2Exe-SetProductVersion 2.0.1.9
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks NumpadZeichner
;@Ahk2Exe-SetProductName NumpadZeichner
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
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 009              M.i.n.i.Bax AHK Skript
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
 * │  MiniBax Skriptoptionen 	(lang)                 [Version 005]                                            │
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
Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\npz.ico	; #NoTrayIcon

; OnExit
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk


;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Variablen, MiniBax zB Pfade     [Version 003]                                                            │
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
	AppName = NumpadZeichner
	Bax_help = help_numpadzeichner	
	Skriptvorlage = MiniBax_008
	Bax_Icon = %Bax_Start%\Grafix\npz.ico
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
; │  MiniBax AppStart mit Subanweisung         [Version 003]                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


;---------------------------------------------------------------->
; AppStart (AutoExec Bereich geht nach dem letzten Eintrag weiter)
; Also hier nach Traymenü. Endet ggf mit return nach den includes
;---------------------------------------------------------------->

	GoSub,INIDELETE
	GoSub,INIREAD
	GoSub,INIWRITE
	GoSub,TRAYMENU
	
; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  Includes (Ende Autoexec)        [Version 008]                                                     │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

#Persistent  							; Verhindert, dass sich das Skript automatisch beendet.
; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox, %Bax_ScriptStart%

; BaxFunk Module
	; #Include %A_ScriptDir%\..\..\Function\BaxFunk_FensterInfo.ahk	
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


	;Gdip_Startup()
	
;-------------------------------------------------------Ende AutoExec
	return
;-------------------------------------------------------Ende AutoExec

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax GUI, Traymenü             [Version 001]                                                           │
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
; │  MiniBax GUI, Dateimenü, kein return        [Version 003]                                                  │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  GUI, Fenster, Teil 1 [Version 001]                                                                │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  GUI, Fenster, Teil 2 [ohne Versionsnummer]                                                        │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;
	return
; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax GUI, TrayFensterFenster (About), ein Label vom Traymenü      [Version 001]                        │
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
; │  MiniBax HotKeys     [Version 001]            ++                                                           │
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
; │  MiniBax Funktionen Standard [Version 002]      Tooltips immer unterschiedlich                             │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  Funktionen von diesem Skript                                                                      │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  Label und Subs    [Version 001]                                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
; 


;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  Sub Ini  [Version 004]                                                                            │
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
	IniWrite, %Bax_IP% , %scriptini%, Nutzerinfo, Bax_IP
	IniWrite, %FensterVersion% , %scriptini%, Nutzerinfo, FensterVersion
	IniWrite, %A_Now%_%AppName% , %scriptini%, Stats_%BaxNutzerName% , LastLogIn

return


;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  Subs GUI-Fenster       [Version 001]                                                              │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax Subs Dateimenü     [Version 001]                                                                  │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  Subs Traymenü    [Version 003]         wenn ohne GUI, OpenGUI auf About                           │
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
	;Gui, Show, Center Autosize, %AppName%
	GoSub,About
	return
; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax Subs Aboutfenster        [Version 002]                                                            │
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
; │ MiniBax  EndSub          [Version 007]        +gdib aus                                                    │
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
ButtonCancel:			; falls es einen Button gibt
GuiEscape:
CleanUp:
SavePosition:
DateiBeenden:     		; Benutzer hat "Exit" im Dateimenü ausgewählt.
	IniWrite, %Lastseen% , %backuptxt%, Stats_%BaxNutzerName% , Lastseen
	IniWrite, %A_Now%_%AppName% , %backuptxt%, Stats_%BaxNutzerName% , LastLogIn
	IniWrite, %AppName%_%CodeVersion%_%Skriptvorlage%_%A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzung_%AppName%
	FileAppend, Nutzung: %A_Now% %A_Tab% Nutzer: %BaxNutzerName%  %A_Tab% App: %AppName%`n , %Bax_Start%\Config\%A_ComputerName%.bax
	DetectHiddenWindows On
	; WinGetPos, X, Y, %AppName%
	; If (x > 0)
	; IniWrite, % " x" X " y" Y, %scriptini%, Position, %AppName%_Position
 	; IniWrite, 0, %scriptini%, Schalter, %AppName%_FensterInfo
	; SoundPlay, NoFile.wav
   	Gui, Destroy			; gibt die Ressource frei
	SoundBeep, 750, 500
  	CTLCOLORS.Free()		; wenn classCTLColours benutzt wurde
	; Gdip_Shutdown(pToken)		; wird in includes gestartet

	if FileExist("..\..\Files\*.htm")
	FileDelete %Bax_Start%\Files\*.htm

ExitApp
