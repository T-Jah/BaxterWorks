CodeVersion := "1.0.0.9", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\fledermond2.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription Tools und Skripte
;@Ahk2Exe-SetFileVersion 1.0.0.9
;@Ahk2Exe-SetProductVersion 1.0.0.9
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks MiniDBs
;@Ahk2Exe-SetProductName MiniDBs
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
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 008             M.a.c.r.o.Bax AHK Skript

/*
 * MiniDBs
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
Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\fledermond2.ico
; OnExit
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   MacroBax  Variablen, zB Pfade     [Version 003]                                                                    │
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
	AppName = MiniDBs
	Bax_help = help_minidb	
	Skriptvorlage = MacroBax_008
	Bax_Icon = %Bax_Start%\Grafix\klee.ico
	LastLogIn = %A_Now%_%AppName%
	LastLogInZeit = %A_Now%
	LetzteAnmeldung = %A_UserName%
	LetzterEinsatz = %A_ComputerName%
	BaxNutzerName = %A_UserName%_%A_ComputerName%
	Bax_Start = %Bax_Start%
	;scriptini = %Bax_Start%\Config\%AppName%.ini

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │               Appstart MacroBax         [Version 001]                                                      │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

GoSub, TRAYMENU

;-----Skript------------------------------------------

Gui, Font, s10 cDarkskyblue, Tahoma,Verdana
Gui, Add, Text, y0 , Datenbank wählen und mit ++ Menü aktivieren

; Gui, Add, Picture, w30 h-1 section xs gStarterBax1 Icon1
;     , %A_ScriptDir%\BW_Allround.exe
; Gui, Add, Text, ys gStarterBax1, Allround DB

Gui, Add, Picture, w30 h-1 section xs gStarterBax2 Icon1
     , %A_ScriptDir%\BW_Bookmarks.exe
Gui, Add, Text, ys gStarterBax2, BaxterWorks Webkatalog

Gui, Add, Picture, w30 h-1 section xs gStarterBax3  Icon1
     , %A_ScriptDir%\CSS_Baustein.exe
Gui, Add, Text, ys gStarterBax3, BaxterWorks CSS Helper

Gui, Show, , BaxterWorks MiniDBs
Return


StarterBax1:
;Run %A_ScriptDir%\BW_Allround.exe
WinClose
return

StarterBax2:
Run %A_ScriptDir%\BW_Bookmarks.exe
WinClose
return

StarterBax3:
Run %A_ScriptDir%\CSS_Baustein.exe
WinClose


;-----Skriptende--------------------------------------
return
;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   EndSub MacroBax        [Version 005]                                                                     │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


GuiEscape:
GuiClose:
ButtonCancel:
quit:
	IniWrite, %Lastseen% , %backuptxt%, Stats_%BaxNutzerName% , Lastseen
	IniWrite, %A_Now%_%AppName% , %backuptxt%, Stats_%BaxNutzerName% , LastLogIn
	IniWrite, %AppName%_%CodeVersion%_%Skriptvorlage%_%A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzung_%AppName%
	FileAppend, Nutzung: %A_Now% %A_Tab% Nutzer: %BaxNutzerName%  %A_Tab% App: %AppName%`n , %Bax_Start%\Config\%A_ComputerName%.bax
ExitApp


;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   SubTray MacroBax         [Version 003]                                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

About:
	MsgBox, 64, About, Mehr über BaxterWorks Software findest du im Netz:`nhttp://www.BaxterWorks.de/software`nCredits an das offizielle Handbuch.`n`nDownload: https://github.com/T-Jah
	return

helptray:
run,http://www.baxterworks.de/software/hilfe/%Bax_help%.htm
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Traymenü   MacroBax            [Version 002]                                                        │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

TRAYMENU:
	Menu, Tray, NoStandard
	Menu, Tray, Add, Über diese App, About
	Menu, Tray, Add, Hilfe, helptray
	Menu, Tray, Add, Exit, quit
	Menu, Tray, Default, Über diese App
	Menu, Tray, Tip, %AppName%  %Codeversion%
	return
