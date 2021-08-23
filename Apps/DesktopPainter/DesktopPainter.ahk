CodeVersion := "1.0.1.0", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\pic.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, Tic und die Gdib-Autoren
;@Ahk2Exe-SetDescription DektopPainter - BildschirmNotizen
;@Ahk2Exe-SetFileVersion 1.0.1.0
;@Ahk2Exe-SetProductVersion 1.0.1.0
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks DektopPainter
;@Ahk2Exe-SetProductName DektopPainter

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
 * DesktopPainter
 * Copyright 2021 T-Jah Tom
 * All Rights Reserved.
 * Use, reproduction, distribution, and modification of this code is subject to the terms and
 * conditions of the MIT license, available at http://www.opensource.org/licenses/mit-license.php
 *
 * Author: T-Jah Tom
 * Project: https://github.com/T-Jah
 *
 * ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * │   Skriptoptionen  MacroBax                [Version 001]    +                                                │
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

SetBatchLines, -1
Coordmode, Pixel, Screen
Coordmode, Mouse, Screen


; Icon
	Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\pic.ico	; #NoTrayIcon
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
	AppName = DesktopPainter
	Bax_help = help_deskpaint
	Skriptvorlage = MacroBax_014
	Bax_Icon = %Bax_Start%\Grafix\pic.ico
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
; │               Appstart MacroBax         [Version 002]                                                      │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Stats.ahk
	GoSub,TRAYMENU
	GoSub,STATS
	
;-----Skript------------------------------------------


ColourN = Red|Green|Blue
ColourH = ffff0000|ff00ff00|ff0000ff
StringSplit, ColourN, ColourN, |
StringSplit, ColourH, ColourH, |

SW := 50
BackColour := 0xff475155

#Include, %A_ScriptDir%\..\..\Lib\Gdip_all.ahk

If !pToken := Gdip_Startup()
{
	MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
	ExitApp
}
;OnExit, Exit

Menu, Tray, NoStandard
Menu, Tray, DeleteAll
Menu, Tray, Add, Toggle Notes, ToggleNotes
Menu,Tray,Add,&Credits...,Credits
Menu,Tray,Add,&Hilfe...,helptray
Menu, Tray, Add
Menu, Tray, Add, Exit, quit

Menu, Tray, Default, Toggle Notes

SysGet, MonitorPrimary, MonitorPrimary
SysGet, WA, MonitorWorkArea, %MonitorPrimary%
WAWidth := WARight-WALeft, WAHeight := WABottom-WATop

Gui, 1: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs
Gui, 1: Show, NA Hide
hwnd1 := WinExist()

Gui, 2: -Caption +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs +Owner1
hwnd2 := WinExist()
Gui, 2: Color, 475155

Gui, 2: Add, Button, x135 y10 w50 gSave Default, &Save...
Loop, %ColourN0%
{
	Gui, 2: Add, Picture, % ((A_Index = 1) ? "x15 y+10" : "x+10 yp+0") " w" SW " h" SW " gChangeColour 0xE v" ColourH%A_Index% " hwnd" ColourN%A_Index%
	
	pBrush := Gdip_BrushCreateSolid("0x" ColourH%A_Index%)
	pBitmap := Gdip_CreateBitmap(SW, SW), G := Gdip_GraphicsFromImage(pBitmap)
	Gdip_FillRectangle(G, pBrush, 0, 0, SW, SW)
	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
	hwnd := ColourN%A_Index%, SetImage(%hwnd%, hBitmap)
	
	Gdip_DeleteBrush(pBrush), Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
}
Gui, 2: Add, Picture, % "x75 y+30 w" SW " h" SW " 0xE hwndPreview"		;%
Gui, 2: Add, Slider, x10 y+40 w180 vPenWidth Tooltip Range1-30 gUpdatePreview, 12
ChosenColour := 0xffff0000
GoSub, UpdatePreview

Gui, 2: Show, w200 h250 x20 y20 NA Hide

pBitmapDraw := Gdip_CreateBitmap(WAWidth, WAHeight), GDrawplus := Gdip_GraphicsFromImage(pBitmapDraw)
Gdip_SetSmoothingMode(GDrawplus, 4)
pBrush := Gdip_BrushCreateSolid(0x01ffffff)
Gdip_FillRectangle(GDrawplus, pBrush, 0, 0, WAWidth, WAHeight)
Gdip_DeleteBrush(pBrush)

hbmDraw := CreateDIBSection(WAWidth, WAHeight), hdcDraw := CreateCompatibleDC(), obmDraw := SelectObject(hdcDraw, hbmDraw), GDraw := Gdip_GraphicsFromHDC(hdcDraw)
Gdip_DrawImage(GDraw, pBitmapDraw, 0, 0, WAWidth, WAHeight)

UpdateLayeredWindow(hwnd1, hdcDraw, WALeft, WATop, WAWidth, WAHeight)

Gdip_DeleteGraphics(GDraw), SelectObject(hdcDraw, obmDraw), DeleteObject(hbmDraw), DeleteDC(hdcDraw)
Return

;####################################################################################

Save:
Gui, 2: +OwnDialogs
FileSelectFolder, OutFolder,,, Speicherort aussuchen
If !OutFolder
Return
Gdip_SaveBitmapToFile(pBitmapDraw, OutFolder "\" A_Now ".png")
Return

;####################################################################################

UpdatePreview:
Gui, 2: Submit, NoHide

pBrush := Gdip_BrushCreateSolid(ChosenColour)
pBrushBack := Gdip_BrushCreateSolid(BackColour)
pBitmap := Gdip_CreateBitmap(SW, SW), G := Gdip_GraphicsFromImage(pBitmap), Gdip_SetSmoothingMode(G, 4)
Gdip_FillRectangle(G, pBrushBack, -2, -2, SW+4, SW+4)
Gdip_FillEllipse(G, pBrush, (SW-PenWidth)//2, (SW-PenWidth)//2, PenWidth, PenWidth)
hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
SetImage(Preview, hBitmap)

Gdip_DeleteBrush(pBrushDraw), Gdip_DeletePen(pPenDraw)
pBrushDraw := Gdip_BrushCreateSolid(ChosenColour), pPenDraw := Gdip_CreatePen(ChosenColour, PenWidth)

Gdip_DeleteBrush(pBrush), Gdip_DeleteBrush(pBrushBack), Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
Return

;####################################################################################

ChangeColour:
ChosenColour := "0x" A_GuiControl
GoSub, UpdatePreview
Return

;####################################################################################

WM_LBUTTONDOWN()
{
	Global

	If (A_Gui != 2)
	Return, -1	
	PostMessage, 0xA1, 2
	Drag := 1
}

;####################################################################################

ToggleNotes:
v := IsWindowVisible(hwnd1) || IsWindowVisible(hwnd2)
Gui, % "2: " (v ? "Hide" : "Show")			;%
Gui, % "1: " (v ? "Hide" : "Show")			;%
SetTimer, CheckPos, % (v ? "Off" : 20)		;%
Return

;####################################################################################

CheckPos:
MouseGetPos, x, y, Win
OnMessage(0x201, (Win = hwnd2) ? "WM_LBUTTONDOWN" : "")
If !GetKeyState("LButton", "P")
Drag := 0
If (Win != hwnd1) || !GetKeyState("LButton", "P") || Drag
{
	Ox := Oy := ""
	Return
}

hbmDraw := CreateDIBSection(WAWidth, WAHeight), hdcDraw := CreateCompatibleDC(), obmDraw := SelectObject(hdcDraw, hbmDraw), GDraw := Gdip_GraphicsFromHDC(hdcDraw)
Gdip_FillEllipse(GDrawplus, pBrushDraw, x-(PenWidth//2), y-(PenWidth//2), PenWidth, PenWidth)
Gdip_DrawLine(GDrawplus, pPenDraw, Ox ? Ox : x, Oy ? Oy : y, x, y)

Gdip_DrawImage(GDraw, pBitmapDraw, 0, 0, WAWidth, WAHeight)
UpdateLayeredWindow(hwnd1, hdcDraw, WALeft, WATop, WAWidth, WAHeight)

Gdip_DeleteGraphics(GDraw), SelectObject(hdcDraw, obmDraw), DeleteObject(hbmDraw), DeleteDC(hdcDraw)
Ox := x, Oy := y
Return

;####################################################################################

IsWindowVisible(hwnd)
{
	Return, DllCall("IsWindowVisible", "UInt", hwnd)
}

;####################################################################################



;-----Skriptende--------------------------------------
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MacroBax Stats     [Version 003]             +include                                                     │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Stats.ahk

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
	Gui, Show, Center Autosize, %AppName%
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
