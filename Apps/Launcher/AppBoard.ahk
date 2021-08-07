CodeVersion := "1.1.4.0", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\logo_tjah2.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription Übersicht Apps auf einem Launchfenster
;@Ahk2Exe-SetFileVersion 1.1.4.0
;@Ahk2Exe-SetProductVersion 1.1.4.0
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks AppBoard
;@Ahk2Exe-SetProductName AppBoard
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
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 029               goPaste AHK Skript

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Direktiven für den Compiler                                                                              │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

/*
 * AppBoard
 * Copyright 2021 T-Jah Tom
 * All Rights Reserved.
 * Use, reproduction, distribution, and modification of this code is subject to the terms and
 * conditions of the MIT license, available at http://www.opensource.org/licenses/mit-license.php
 *
 * Author: T-Jah Tom
 * Project: https://github.com/T-Jah
 *
 * ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * │   Skriptoptionen 	                       [Version 021]                                                    │
 * └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 *
 *                         BaxterWorks Software:	http://www.baxterworks.de/software
 *			                 http://blog.baxterworks.de
 *                                       ^ STRG + Shift ! Alt # WIN
 * 
 */


#SingleInstance force 		; oder off, force, ignore
#NoEnv				
#Persistent			; mit ExitApp statt mit Exit beenden
#MaxMem 512			
#KeyHistory 500
#installKeybdHook
DetectHiddenWindows On		; Ermöglicht die Erkennung des versteckten Hauptfensters eines Skripts.
SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
SetWorkingDir %A_ScriptDir%
FileEncoding UTF-8
SetNumlockState, AlwaysOn	; Set Lock keys permanently - nur im ersten Skipt aufrufen (Tom)
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk

SetBatchLines -1
;Icon
Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\logo_tjah2.ico




;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Variablen, zB Pfade     [Version 014]                                                                    │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;
;---------------------------------------------------------------- Teil 1, Pfadfestlegung
;---- diese Variablen nicht über die ini, da Änderung nicht vorgesehen

; VariablenSetup LAN
LetzteAnmeldung = %A_UserName%
LetzterEinsatz = %A_ComputerName%

 Bax_exe := A_LineFile
 Bax_WebserverRoot = T:\100_Content\40_Web\Server\htdocs
 Bax_AHKBax = T:\100_Content\50_Skripte\AHK-Skripte
 Bax_Bar = %A_AppData%\Microsoft\Internet Explorer\Quick Launch

;---------------------------------------------------------------- Teil 2, Rechnerabfrage
;---- diese Variablen nicht über die ini, da Änderung nicht vorgesehen

if (A_ComputerName = "HAPE")
{
 Bax_IniDir = D:\10_CopyCloudia\100_Content\50_Skripte\AHK-Skripte\BaxterWorks Software\Tom\Config
 PortableDir = D:\01_PortableApps
 Bax_FavFolder1 = T:\200_Werkstatt\05_Schreiberwerkstatt\MDzuHTML
 Bax_FavFolder2 = D:\10_CopyCloudia\100_Content\50_Skripte\AHK-Skripte\BaxterWorks Software
 Bax_ScriptStart = D:\10_CopyCloudia\100_Content\50_Skripte\AHK-Skripte\BaxterWorks Software\Tom
 Lokal_AHKBax = D:\10_CopyCloudia\100_Content\50_Skripte\AHK-Skripte
}
else if (A_ComputerName = "OMEN")
{
 Bax_IniDir = E:\001_CopyCloudia\100_Content\50_Skripte\AHK-Skripte\BaxterWorks Software\Tom\Config
 PortableDir = E:\003_PortableApps
 Bax_FavFolder1 = T:\200_Werkstatt\05_Schreiberwerkstatt\MDzuHTML
 Bax_FavFolder2 = E:\001_CopyCloudia\100_Content\50_Skripte\AHK-Skripte\BaxterWorks Software
 Bax_ScriptStart = E:\001_CopyCloudia\100_Content\50_Skripte\AHK-Skripte\BaxterWorks Software\Tom
 Lokal_AHKBax = E:\001_CopyCloudia\100_Content\50_Skripte\AHK-Skripte
}
else if (A_ComputerName = "MALI")
{
 Bax_IniDir = D:\001_CopyCloudia\100_Content\50_Skripte\AHK-Skripte\BaxterWorks Software\Tom\Config
 PortableDir = D:\003_PortableApps
 Bax_FavFolder1 = T:\200_Werkstatt\05_Schreiberwerkstatt\MDzuHTML
 Bax_FavFolder2 = D:\001_CopyCloudia\100_Content\50_Skripte\AHK-Skripte\BaxterWorks Software
 Bax_ScriptStart = D:\001_CopyCloudia\100_Content\50_Skripte\AHK-Skripte\BaxterWorks Software\Tom
 Lokal_AHKBax = D:\001_CopyCloudia\100_Content\50_Skripte\AHK-Skripte
}
else if (A_ComputerName = "ROBBIE")
{
 Bax_IniDir = D:\10_CopyCloudia\100_Content\50_Skripte\AHK-Skripte\BaxterWorks Software\Tom\Config
 PortableDir = c:\PortableApps
 Bax_FavFolder1 = T:\200_Werkstatt\05_Schreiberwerkstatt\MDzuHTML
 Bax_FavFolder2 = D:\10_CopyCloudia\100_Content\50_Skripte\AHK-Skripte\BaxterWorks Software
 Bax_ScriptStart = D:\10_CopyCloudia\100_Content\50_Skripte\AHK-Skripte\BaxterWorks Software\Tom
 Lokal_AHKBax = D:\10_CopyCloudia\100_Content\50_Skripte\AHK-Skripte
}

else
 {
 MsgBox Rechner unbekannt, Pfad nicht gesetzt.
 GoSub, DateiBeenden
 }

; Variablentest
; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox,  %Bax_ScriptStart% 


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   AppStart mit Subanweisung         [Version 003]     +                                                    │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;
;---------------------------------------------------------------->
; AppStart (AutoExec Bereich geht nach dem letzten Eintrag weiter)
; Also hier nach Traymenü.
;---------------------------------------------------------------->

; App Start
applicationname=AppBoard
scriptini=%Bax_IniDir%\%applicationname%.ini
homeini=%Bax_IniDir%\tom.ini
Gosub,currentTime
Gosub,guiupdator
SetTimer,currentTime,500
GoSub,TRAYMENU


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Includes (Ende Autoexec)        [Version 006]                                                            │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

#Persistent  							; Verhindert, dass sich das Skript automatisch beendet.
; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox, %Bax_ScriptStart%

	#Include %A_ScriptDir%\..\..\Function\BaxFunk_IconShow.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_LicenceWindow.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_2Win.ahk
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Dropper.ahk
	#include %A_ScriptDir%\..\..\Lib\funk_panic.ahk
	#Include %A_ScriptDir%\..\..\Lib\funk_toggle.ahk
	#Include %A_ScriptDir%\..\..\Lib\Gdip_all.ahk
	#Include %A_ScriptDir%\..\..\Lib\tf.ahk
 
	#Include %A_ScriptDir%\..\..\Lib\datecalc.ahk
	#Include %A_ScriptDir%\..\..\Lib\ipfindmap.ahk
	#Include %A_ScriptDir%\..\..\Lib\keepalive.ahk
	#Include %A_ScriptDir%\..\..\Lib\MouseisOver.ahk
	#Include %A_ScriptDir%\..\..\Lib\ObjCSV.ahk
	#Include %A_ScriptDir%\..\..\Lib\toggle_hiddenfiles.ahk
	#Include %A_ScriptDir%\..\..\Lib\toggle_lightdark.ahk


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Traymenü                    [Version 004]                                                           │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

TRAYMENU:
Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray,NoMainWindow
Menu,Tray,Add,%applicationname%,OpenGUI
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
Menu,Tray,Tip,%applicationname% %Codeversion%
Menu,Tray,Default,%applicationname%

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Dateimenü, kein return        [Version 007]                                                         │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

Menu, Dateimenü, Add, reload, Config
Menu, Dateimenü, Icon, reload, C:\WINDOWS\System32\SHELL32.dll,147
Menu, Dateimenü, Add, Exit, Beenden
Menu, Dateimenü, Icon, Exit, C:\WINDOWS\System32\SHELL32.dll,28

Menu, Configmenü, Add, Toggle DesktopSymbol, %applicationname%_Icon 
Menu, Configmenü, ToggleCheck, Toggle DesktopSymbol       
Menu, Configmenü, Add, Toggle BaxBarSymbol, %applicationname%_BaxBar 
Menu, Configmenü, ToggleCheck, Toggle BaxBarSymbol       

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

Menu, MeineMenüleiste, Add, &Datei, :Dateimenü
Menu, MeineMenüleiste, Add, Einstellungen, :Configmenü
Menu, MeineMenüleiste, Add, Tools, :Toolsmenü
Menu, MeineMenüleiste, Add, BaxterWorks, :Baxmenü
Menu, MeineMenüleiste, Add, ?, :Hilfsmenü



; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Fenster, Teil 1 [Version 013]                                                                       │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


Gui, Font, s10 cWhite, Verdana,Tahoma
Gui, Margin, 0, 10
Gui, Color, White

IniRead, Pos, %scriptini%, Position, AppBoard_Position

If (Pos = "ERROR") {
	IniWrite, x40 y40, %scriptini%, Position, AppBoard_Position
	Gui, Show, x40 y40, AppBoard Error
}
Else

GuiControlget, all
IniRead, AppBoard_Icon, %scriptini%, Schalter, AppBoard_Icon

; --------------------------------------------------------------- TextBox für die Fehlersuche
; MSgBox, %AppBoard_Icon%
If (AppBoard_Icon = "1") {
	Menu, Configmenü, Check, 1&
}
If (AppBoard_Icon = "0") {
	Menu, Configmenü, UnCheck, 1&
}

IniRead, AppBoard_BaxBar, %scriptini%, Schalter, AppBoard_BaxBar

If (AppBoard_BaxBar = "1") {
	Menu, Configmenü, Check, 2&
}
If (AppBoard_BaxBar = "0") {
	Menu, Configmenü, UnCheck, 2&
}

Gui,Menu, MeineMenüleiste
Gui, Font
Gui, Font, s12 cWhite, Verdana,Tahoma


IniRead, AppBoard_AOTStatus, %scriptini%, Schalter, AppBoard_AOTStatus
If (AppBoard_AOTStatus = "1") {
	Gui,+AlwaysOnTop
}
IniRead, AppBoard_AOT, %scriptini%, Schalter, AppBoard_AOT
If (AppBoard_AOT = "-") {
	WinSet, AlwaysOnTop, Off
}
else 
AppBoard_AOT := +
WinSet, AlwaysOnTop, On
Gui, Add, CheckBox, y5 x10 vAppBoard_AOTStatus gAOTLabel Checked%AppBoard_AOT%, Always on top

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Fenster, Teil 2 [ohne Versionsnummer]                                                               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

minute=100
minute*=60
x=0


;GUI
Gui Font, s16 clime, Verdana,Tahoma,Segoe UI
Gui, Color, Black
;Gui, -Caption
Gui, Add, Text, x480 y5 w40 vsimpletime, %Time%
Gui Font
Gui, Add, Picture, x850 y5 w250 h200 , %A_ScriptDir%\..\..\Grafix\bw_software.png
Gui Font, s10 cwhite, Verdana,Tahoma,Segoe UI 

gui, add, text, vtext x0 y0 hidden
Gui, Add, Progress, x80 y509 w860 h30 cRed vprogress, %text%

guicontrol,,text,%percent% %x%
guicontrol,,progress,%percent%

settimer,progress,100 ;Change this to 100 if you want it to update the progress bar 10 times a second

Gui Font
; ListBox
Gui Font, s9 Blue cBlack, Verdana,Tahoma,Segoe UI 
Gui, Add, ListBox, vMeineListBox gMeineListBox w330 r15 x720 y220

Gui, Add, Button, Default, OK
Loop, M:\010_ToDoListen\*.*  ; Ordner und Platzhaltermuster je nach Bedarf anpassen.
{
    GuiControl,, MeineListBox, %A_LoopFileFullPath%
}
Gui Font
Gui, Add, Button, x992 y509 w90 h30 gGuiClose, Beenden

WinSet, AlwaysOnTop, on
AOT:=0
Gui, Show, %Pos% w1115 h562, %applicationname%   
Return


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, TrayFensterFenster (About), ein Label vom Traymenü      [Version 001]                               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;



ABOUT:
Gui,99:Destroy
Gui,99:Margin,20,20
Gui,99:Color, silver

Gui,99:Add,Picture, w90 h90 Icon1,%applicationname%.exe
Gui,99:Font,Bold 
Gui,99:Font, s10 cGreen, Verdana
Gui,99:Add,Text, R1 xp+100 ,%applicationname% - %Firma% - %Codeversion% 
Gui,99:Font
Gui,99:Font, s9 cBlack, Verdana
Gui,99:Add,Text, R3 ,Das AppBoard ist die Übersicht und das Launchpad`nVon hier kannst du fast alle Apps starten.
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

Gui,99:Show,,%applicationname% About 
GuiControl,, BaxProgress, +10

hCurs:=DllCall("LoadCursor","UInt",NULL,"Int",32649,"UInt") ;IDC_HAND
OnMessage(0x200,"WM_MOUSEMOVE") 
Return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   HotKeys                                                                                                  │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Funktionen Standard [Version 002]       +                                                                │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


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


MeineListBox:
if (A_GuiEvent != "DoubleClick")
    return
; Ansonsten wurde ein Doppelklick auf einen Listeneintrag gemacht, also wie OK-Drücken behandeln
; und zum nächsten Label übergehen.
ButtonOK:
GuiControlGet, MeineListBox  ; Ermittelt die aktuelle Auswahl in der ListBox.
Run, %MeineListBox%,, UseErrorLevel
if (ErrorLevel = "ERROR")
    MsgBox Die angegebene Datei konnte nicht ausgeführt werden. Scheinbar fehlt ein passendes Programm dafür.
return


BaxProgress:



progress:
x+=1
percent:=(100*x)/minute ;Change this to 10 if you change the above number to 100
guicontrol,,text,%percent% %x%
guicontrol,,progress,%percent%
if percent=100
{
 msgbox Zeit sich zu bewegen. Wenn du bis jetzt`nnoch nichts geöffnet hast, dann scheint es`nnichts wichtiges zu geben.
 settimer,progress,off
 SoundBeep, 550, 500
 SoundBeep, 650, 500
}
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
; │   Sub Ini  [Version 013]                                                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

INIDELETE:
IniDelete, %scriptini%, Nutzerinfo, 
IniDelete, %scriptini%, Info_localLAN_Pfade, 
IniDelete, %scriptini%, Info_LAN_Pfade, 

INIREAD:
IniRead, LetzterNutzer , %scriptini%, Nutzerinfo, Letzter Nutzer
IniRead, LetzterRechner , %scriptini%, Nutzerinfo, Letzter Rechner
IniRead, DeinOrdner1 , %homeini%, APP_2Win, DeinOrdner1
IniRead, DeinOrdner2 , %homeini%, APP_2Win, DeinOrdner2
IniRead, Bax_FixDir , %homeini%, Pfade, Bax_FixDir
IniRead, Bax_JobDir , %homeini%, iSafeText, Bax_JobDir

INIWRITE:
IniWrite, %LetzteAnmeldung% , %scriptini%, Nutzerinfo, Letzter Nutzer
IniWrite, %LetzterEinsatz% , %scriptini%, Nutzerinfo, Letzter Rechner
IniWrite, %A_LineFile% , %scriptini%, Info, Bax_exe
IniWrite, %scriptini% , %scriptini%, Info_localLAN_Pfade, scriptini
IniWrite, %Bax_IniDir% , %scriptini%, Info_localLAN_Pfade, Bax_IniDir
IniWrite, %PortableDir% , %scriptini%, Info_localLAN_Pfade, PortableDir
IniWrite, %Bax_FavFolder1% , %scriptini%, Info_localLAN_Pfade, Bax_FavFolder1
IniWrite, %Bax_FavFolder2% , %scriptini%, Info_localLAN_Pfade, Bax_FavFolder2
IniWrite, %Bax_ScriptStart% , %scriptini%, Info_localLAN_Pfade, Bax_ScriptStart
IniWrite, %Lokal_AHKBax% , %scriptini%, Info_localLAN_Pfade, Lokal_AHKBax
IniWrite, %Bax_WebserverRoot% , %scriptini%, Info_LAN_Pfade, Bax_WebserverRoot
IniWrite, %Bax_AHKBax% , %scriptini%, Info_LAN_Pfade, Bax_AHKBax

return



; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs GUI-Fenster       [Version 006]     +                                                               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

;---------------------------------------------------------------->
; ANFANG Labelbereich 2
;---------------------------------------------------------------->

; Uhrzeitanzeige

currentTime:
FormatTime,Time,T12,hh:mm:ss
Gosub,guiupdator
Return

guiupdator:
GuiControl, text, simpletime , %Time%
return

Return


; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs GUI-Fenster       [Version 006]      ab hier Standard                                               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Always on Top Toggle, gehört zur Checkbox in der GUI, sofern vorhanden.

AOTLabel:
Gui,Submit,NoHide
IniWrite, %AppBoard_AOTStatus%, %scriptini%, Schalter, AppBoard_AOTStatus

; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox, %AppBoard_AOTStatus%  ; sollte 0 oder 1 sein
if (AppBoard_AOTStatus=1)
	{
		WinSet, AlwaysOnTop, On
		IniWrite, + , %scriptini%, Schalter, AppBoard_AOT

		; MsgBox, an
	}
else
	{
		WinSet, AlwaysOnTop, Off
		IniWrite, - , %scriptini%, Schalter, AppBoard_AOT

		; MsgBox, aus
	}
Return


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs Dateimenü     [Version 008]                                                                         │
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

AppBoard_Icon:
IniRead, AppBoard_Icon, %scriptini%, Schalter, AppBoard_Icon
AppBoard_Icon := AppBoard_Icon

; --------------------------------------------------------------- TextBox für die Fehlersuche
;MsgBox, jetzt %AppBoard_Icon%
if (AppBoard_Icon = "0")
{
	Menu, Configmenü, Check, Toggle DesktopSymbol  
	FileCreateShortcut, %Bax_exe%, %A_Desktop%\%applicationname%.lnk, %A_ScriptDir%, "%A_ScriptFullPath%", BaxterWorks Software mit STRG+Alt+M starten, %A_ScriptDir%\..\..\Grafix\logo_tjah.ico, M      
	IniWrite, 1, %scriptini%, Schalter, AppBoard_Icon
}
if (AppBoard_Icon = "1")
{
    	Menu, Configmenü, UnCheck, Toggle DesktopSymbol   
	FileDelete, %A_Desktop%\%applicationname%.lnk
	IniWrite, 0, %scriptini%, Schalter, AppBoard_Icon
}
if (AppBoard_Icon = "ERROR")
{
    	Menu, Configmenü, UnCheck, Toggle DesktopSymbol   
	FileDelete, %A_Desktop%\%applicationname%.lnk
	IniWrite, 0, %scriptini%, Schalter, AppBoard_Icon
	MsgBox, BaxterWorks meldet einen Fehler. Ist die ini-Datei ok? Wenn der Fehler bleibt`nbitte in der ini den Error mit 0 ersetzen.
}

return

AppBoard_BaxBar:
IniRead, AppBoard_BaxBar, %scriptini%, Schalter, AppBoard_BaxBar
AppBoard_BaxBar := AppBoard_BaxBar

; --------------------------------------------------------------- TextBox für die Fehlersuche
;MsgBox, jetzt %AppBoard_BaxBar%
if (AppBoard_BaxBar = "0")
{
	Menu, Configmenü, Check, Toggle BaxBarSymbol  
	FileCreateShortcut, %Bax_exe%, %Bax_Bar%\%applicationname%.lnk, %A_ScriptDir%, "%A_ScriptFullPath%", BaxterWorks Software, %A_ScriptDir%\..\..\Grafix\logo_tjah.ico,      
	IniWrite, 1, %scriptini%, Schalter, AppBoard_BaxBar
}
if (AppBoard_BaxBar = "1")
{
    	Menu, Configmenü, UnCheck, Toggle BaxBarSymbol
	FileDelete, %Bax_Bar%\%applicationname%.lnk
	IniWrite, 0, %scriptini%, Schalter, AppBoard_BaxBar
}
if (AppBoard_BaxBar = "ERROR")
{
    	Menu, Configmenü, UnCheck, Toggle BaxBarSymbol
	FileDelete, %Bax_Bar%\%applicationname%.lnk
	IniWrite, 0, %scriptini%, Schalter, AppBoard_BaxBar
	MsgBox, BaxterWorks meldet einen Fehler. Ist die ini-Datei ok? Wenn der Fehler bleibt`nbitte in der ini den Error mit 0 ersetzen.
}

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
;---------------------------------------------

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
; Das wird auf diese Weise gemacht, weil einige URLs andere URLs eingebettet haben:
URLStart1 := InStr(URLSuchZkette, "https://")
URLStart2 := InStr(URLSuchZkette, "http://")
URLStart3 := InStr(URLSuchZkette, "ftp://")
URLStart4 := InStr(URLSuchZkette, "www.")

; Findet die Startposition ganz links:
URLStart := URLStart1  ; Setzt den Standardwert.
Loop
{
    ; Es kommt der Leistung zugute (zumindest in einem Skript mit vielen Variablen), wenn
    ; "URLStart%A_Index%" nur einmal aufgelöst wird:
    ArrayElement := URLStart%A_Index%
    if (ArrayElement = "")  ; Ende des Pseudo-Arrays erreicht.
        break
    if (ArrayElement = 0)  ; Dieses Element ist disqualifiziert.
        continue
    if (URLStart = 0)
        URLStart := ArrayElement
    else ; URLStart beinhaltet eine gültige Position, also mit ArrayElement vergleichen.
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
; Wenn die obige Schleife aufgrund eines nicht-vorhandenen Endungszeichen keine Iteration hat,
; bleibt der Inhalt der URL-Variable unberührt.

; Wenn die URL mit einem Anführungszeichen endet, wird sie entfernt.  Vorerst wird StringReplace verwendet, aber
; beachten Sie, dass Anführungszeichen in URLs legitim sind, so dass sie dadurch
; beschädigt werden könnten:
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
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/Credits.htm, %A_ScriptDir%\..\..\Files\Credits.htm
}
run,%A_ScriptDir%\..\..\Files\Credits.htm
return

MenuHilfe:
If !(FileExist)
{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help.htm, %A_ScriptDir%\..\..\Files\help.htm
}
run,%A_ScriptDir%\..\..\Files\help.htm
return

MenuInfo:
run, %A_WinDir%\notepad.exe %A_ScriptDir%\..\ChangeLog\Versionsinfo_%applicationname%.txt
return

Lizenzmenu:
Bax_LicenceGui_Create()
return



; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs Traymenü    [Version 004]       + help_AppBoard statt help                                           │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

Licence:
Bax_LicenceGui_Create()
return

HilfeTray:
If !(FileExist)
{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_AppBoard.htm, %A_ScriptDir%\..\..\Files\help_AppBoard.htm
}
run,%A_ScriptDir%\..\..\Files\help_AppBoard.htm
return

Credits:
If !(FileExist)
{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/Credits.htm, %A_ScriptDir%\..\..\Files\Credits.htm
}
run, %A_ScriptDir%\..\..\Files\Credits.htm
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
Run,%A_ScriptDir%\..\ChangeLog\Versionsinfo_%applicationname%.txt
return

HotKeys:
ListHotkeys
return

Reload:
reload
return

OpenGUI:
Gui, Show, Center Autosize, %applicationname%
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs Aboutfenster        [Version 003]                                                                   │
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
; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   EndSub          [Version 008]                                                                            │
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

SavePosition:
DetectHiddenWindows On
WinGetPos, X, Y, %applicationname%
If (x > 0)
	IniWrite, % " x" X " y" Y, %scriptini%, Position, AppBoard_Position
	; SoundPlay, NoFile.wav
   	Gui, Destroy			; gibt die Ressource frei
	SoundBeep, 750, 500
  	CTLCOLORS.Free()		; wenn classCTLColours benutzt wurde

if FileExist("..\..\Files\*.htm")
FileDelete %A_ScriptDir%\..\..\Files\*.htm


ExitApp

