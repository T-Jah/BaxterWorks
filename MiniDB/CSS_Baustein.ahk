CodeVersion := "1.0.0.5", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\autotext.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription CSS_Baustein DB
;@Ahk2Exe-SetFileVersion 1.0.0.5
;@Ahk2Exe-SetProductVersion 1.0.0.5
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks CSS_Baustein DB
;@Ahk2Exe-SetProductName CSS_Baustein
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
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 011               MusterBax AHK Skript

/*
 * CSS_Baustein
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
	Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\autotext.ico	; #NoTrayIcon
; OnExit
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk

AppName = CSS_Baustein
GoSub, TRAYMENU

txtObjekt := {}

Loop, read, CSSbausteine.txt, 
{	
		Einzelmerkmale 			:= StrSplit(A_LoopReadLine, A_Tab)
		
		txtObjekt[Einzelmerkmale[2] Einzelmerkmale[3]] := Einzelmerkmale[4]
				
		Menu, % Einzelmerkmale[2], add, % Einzelmerkmale[3], txtSenden
		Menu, % Einzelmerkmale[1], add, % Einzelmerkmale[2],	% ":" Einzelmerkmale[2]

}

:*:++::
Menu, Start, add, Basic, :Basic
Menu, Start, add, Bilder, :Bilder
Menu, Start, add, Einfach, :Einfach
Menu, Start, add, IDs, :IDs
Menu, Start, add, Links, :Links
Menu, Start, add, Block, :Block
Menu, Start, add, Musterdatei, :Musterdatei
Menu, Start, add, Rahmen, :Rahmen
Menu, Start, add, sonstige, :sonstige
Menu, Start, add, Spezial, :Spezial
Menu, Start, show
Return

txtSenden:
CSSbaustein := txtObjekt[A_ThisMenu A_ThisMenuItem]
Sendinput % CSSbaustein
return


GuiEscape:
GuiClose:
ButtonCancel:
quit:
ExitApp


About:
	MsgBox, 64, About, CSS Baustein ist eine MiniDB (Datenbank) von BaxterWorks`nhttp://www.BaxterWorks.de`nCredits an das offizielle Handbuch.`n`nöffne ein Textfenster und drücke zweimal das + Zeichen. Mehr in der BaxterWorks Hilfe
	return

helptray:
run,http://www.baxterworks.de/software/hilfe/help.htm
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Traymenü  mini              [Version 002]                                                           │
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
