CodeVersion := "1.0.1.8", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\Grafix\bax.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription Tools und Skripte
;@Ahk2Exe-SetFileVersion 1.0.1.8
;@Ahk2Exe-SetProductVersion 1.0.1.8
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks
;@Ahk2Exe-SetProductName BaxterWorks
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │            __________                  __                __      __             __                         │
; │            \______   \_____  ___  ____/  |_  ___________/  \    /  \___________|  | __  ______             │
; │             |    |  _/\__  \ \  \/  /\   __\/ __ \_  __ \   \/\/   /  _ \_  __ \  |/ / /  ___/             │
; │             |    |   \ / __ \_>    <  |  | \  ___/|  | \/\        (  <_> )  | \/    <  \___ \              │
; │             |______  /(____  /__/\_ \ |__|  \___  >__|    \__/\  / \____/|__|  |__|_ \/____  >             │
; │                    \/      \/      \/           \/             \/                   \/     \/              │
; │              http://www.baxterworks.de/software                      (c) 1999-2021 T-Jah Tom               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;   Direktiven nach ganz oben                     STARTERSKRIPT                                  Tom AHK Skript

/*
 * BaxterWorks
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
	SetNumlockState, AlwaysOn	
	SetCapsLockState, AlwaysOff
	SetScrollLockState, AlwaysOff
; Icon
	Menu Tray, Icon, %A_ScriptDir%\Grafix\bax.ico	; #NoTrayIcon

; OnExit
	#Include %A_ScriptDir%\Function\BaxFunk_Exit.ahk

; Save settings on system shutdown
	OnMessage(0x16, "SaveSettings") ; WM_ENDSESSION

;---------------------------------------------------------------------------------------------------------------

;┌────────────────────────────────────┐
;│ Teil1:                             │
;│   - erste Variablen setzen         │
;│   - zur Info in ini schreiben      │
;│   - die AppBar wird vorbereitet    │
;│   - Erster Start? Ab zur config    │
;│   - oder weiter im Skript          │
;└────────────────────────────────────┘


; Startumgebungsvariablen festlegen
	AppName = BaxterWorks
	Bax_Bar = %A_Appdata%\Microsoft\Internet Explorer\Quick Launch
	Bax_Start = %A_ScriptDir%
	Bax_exe = %A_LineFile%
	Bax_Icon = %Bax_Start%\Grafix\bax.ico
	homeini = %Bax_Start%\Config\BaxterWorks.ini
	userini = %Bax_Start%\Config\%A_ComputerName%.ini
	scriptini = %Bax_Start%\Config\%AppName%.ini
	FensterVersion = 004
	PCName = %A_ComputerName%
	
; Startumgebungsvariablen erfassen
	LetzteAnmeldung = %A_UserName%
	LetzterEinsatz = %A_ComputerName%

; Startumgebungsvariablen in homeini (BaxterWorks) schreiben, wird von allen Skripten gelesen
	IniDelete, %homeini%, FixVars, 
	IniWrite, %A_ScriptDir% , %homeini%, FixVars, Bax_Start
	IniWrite, %Bax_Start%\Config\BaxterWorks.ini , %homeini%, FixVars, homeini
	IniWrite, %Bax_Start%\Config\BaxterWorks.ini , %homeini%, SkriptInfo, Bax_exe
	IniWrite, %userini% , %homeini%, FixVars, userini
	IniWrite, %A_Appdata%\Microsoft\Internet Explorer\Quick Launch , %homeini%, FixVars, Bax_Bar
	IniWrite, %A_ComputerName% , %homeini%, FixVars, PCName
	IniWrite, %FensterVersion% , %homeini%, FixVars, FensterVersion

; Das Menü der AppBar wird gecheckt, bzw das Symbol des Menüs
	if !FileExist("%Bax_Bar%\00AppBar.lnk")
	FileCreateShortcut, %Bax_Start%\Apps\BWAppBar\00AppBar.exe, %Bax_Bar%\00AppBar.lnk, %Bax_Start%, "%A_ScriptFullPath%", Menü mit Rechtsklick oder WIN+Z, %Bax_Start%\Grafix\menuico.ico,   

; Das Symbol für BaxterWorks wird gecheckt
	if !FileExist("%Bax_Bar%\01_BaxterWorks.lnk")
	FileCreateShortcut, %Bax_Start%\BaxterWorks.exe, %Bax_Bar%\01_BaxterWorks.lnk, %Bax_Start%, "%A_ScriptFullPath%", Menü mit Rechtsklick oder WIN+Z, %Bax_Start%\Grafix\bax.ico,   
   

; Erster Start? Pfade müssen gesetzt werden mit einer ExtraApp

if !FileExist("%Bax_Start%\Config\%A_Computername%.ini")
	GoSub, INIREAD
	Loop, read, %userini%    ; die gesamtzahl der zeilen ermitteln
        lineMax++
	if lineMax > 10
	GoSub, 2ndstep
	else {

; öffnet GetReadyBax.exe
	
	MsgBox Eine Datei wurde gelöscht oder noch nicht erstellt oder nicht zu Ende bearbeitet.`nDu wirst zur Konfiguration gezwungen ;)
	
	run, %Bax_Start%\Apps\GetReadyBax\GetReadyBax.exe
	;run, %Bax_Start%\Apps\GetReadyBax\GetReadyBax.ahk
	ExitApp
	return
}
;┌──────────────────────────────────────────┐
;│ Teil2:                                   │
;│   - Always running apps starten          │
;│   - IP Adresse ermitteln und speichern   │
;│   - Hotkeys				    │
;│   - FileInstall			    │
;│   - BaxFunk Module		            │
;└──────────────────────────────────────────┘

; Teil 2

	2ndstep:
	;MsgBox Alle Pfade erfolgreich gesetzt, dann kann es hier weiter gehen:

; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   AppStart mit Subanweisung         [Version 002, nur Starterskript]                                       │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;
; IP Logbuch, archiviert die eigene externe IP
	URLDownloadToFile,http://www.netikus.net/show_ip.html, %Bax_Start%\Files\IP LogBuch\showip_%A_YYYY%_%A_MM%_%A_DD%.txt
	if ErrorLevel = 1
  	{
	MsgBox, 16,IpAddresses,Your public Ipaddress could not be detected.
	}
	FileReadLINE,BaxIP,%Bax_Start%\Files\IP LogBuch\showip_%A_YYYY%_%A_MM%_%A_DD%.txt, 1
	IniWrite, %BaxIP% , %homeini%, Netzinfo, Letzte IP



;┌──────────────────────────────────────────┐
;│ Teil3:                                   │
;│   - Ini Dateien  			    │
;│   - TrayMenü				    │
;│   - AboutFenster			    │
;│   - Includes       			    │
;│   -  		        	    │
;└──────────────────────────────────────────┘

; Teil 3

; Gute Stelle, um noch mehr Variablen zu laden
	GoSub, INIREAD
	GoSub, BaxMenu
	GoSub, TRAYMENU
; Wichtige Apps	und HK
	#Include %A_ScriptDir%\Function\BaxFunk_appcheck.ahk	
	#Include %A_ScriptDir%\Function\BaxFunk_Keys.ahk
	BaxFunk_appststart()

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxMenu, BaxterWorks Hauptmenü per HotKey      [Version 001]                                             │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
; Menü am besten von unten nach oben bearbeiten hier im Skript

BaxMenu:
; Erstellt ein aufklappbares Menü durch Hinzufügen von Menüpunkten.
	Menu, BaxMenu, Add, Liste der Hotkeys anzeigen, HKHandler1		; Untermenü HotKeys zeigen
	Menu, BaxMenu, Icon, Liste der Hotkeys anzeigen, C:\WINDOWS\System32\SHELL32.dll,270    
	Menu, BaxMenu, Add, Liste druckfähig in Datei öffnen, HKHandler2	; Untermenü HotKeys liste ducken
	Menu, BaxMenu, Icon, Liste druckfähig in Datei öffnen, C:\WINDOWS\System32\SHELL32.dll,17    
	Menu, BaxMenu, Add  							; Fügt eine Trennlinie ein.
; Einträge Untermenü BW
	Menu, SubBaxMenuBW, Add, BWAppBar, SubsBWHandler1
	Menu, SubBaxMenuBW, Icon, BWAppBar, Grafix\appbar.ico,1     
	Menu, SubBaxMenuBW, Add, 00AppBar, SubsBWHandler2
	Menu, SubBaxMenuBW, Icon, 00AppBar, Grafix\menuico.ico,1     
	Menu, SubBaxMenuBW, Add, CaptureBax, SubsBWHandler3
	Menu, SubBaxMenuBW, Icon, CaptureBax, Grafix\schere.ico,1     
	Menu, SubBaxMenuBW, Add, KillerBax, SubsBWHandler8
	Menu, SubBaxMenuBW, Icon, KillerBax, Grafix\killerbax.ico,1     
	Menu, SubBaxMenuBW, Add, AppBoard, SubsBWHandler9
	Menu, SubBaxMenuBW, Icon, AppBoard, Grafix\logo_tjah.ico,1     
	Menu, SubBaxMenuBW, Add, MagnifyBax - Lupe, SubsBWHandler10
	Menu, SubBaxMenuBW, Icon, MagnifyBax - Lupe, Grafix\lupe.ico,1     
	Menu, SubBaxMenuBW, Add, NumpadZeichner, SubsBWHandler12
	Menu, SubBaxMenuBW, Icon, NumpadZeichner, Grafix\npz.ico,1     
	Menu, SubBaxMenuBW, Add, SuchBax, SubsBWHandler13
	Menu, SubBaxMenuBW, Icon, SuchBax, Grafix\welt.ico,1     
	Menu, SubBaxMenuBW, Add, Digitaluhr, SubsBWHandler14
	Menu, SubBaxMenuBW, Icon, Digitaluhr, Grafix\uhr3.ico,1     
; Einträge Untermenü Hilfe
	Menu, SubBaxMenuHelp, Add, Hilfetexte BaxterWorks, SubsHilfeHandler1
	Menu, SubBaxMenuHelp, Icon, Hilfetexte BaxterWorks, Grafix\bax.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte BWAppBar, SubsHilfeHandler2
	Menu, SubBaxMenuHelp, Icon, Hilfetexte BWAppBar, Grafix\appbar.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte 00AppBar, SubsHilfeHandler3
	Menu, SubBaxMenuHelp, Icon, Hilfetexte 00AppBar, Grafix\menuico.ico,1     
; Einträge Untermenü Versionsinfo
	Menu, SubBaxMenuVersion, Add, Versionsinfo BaxterWorks, SubsMenuVersioninfo1
	Menu, SubBaxMenuVersion, Icon, Versionsinfo BaxterWorks, Grafix\bax.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo BWAppBar, SubsMenuVersioninfo2
	Menu, SubBaxMenuVersion, Icon, Versionsinfo BWAppBar, Grafix\appbar.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo 00AppBar, SubsMenuVersioninfo3
	Menu, SubBaxMenuVersion, Icon, Versionsinfo 00AppBar, Grafix\menuico.ico,1     
; Einträge Untermenü Telegram
	Menu, SubBaxMenuTG, Add, T-Jah Tom @BaxterWorks, TGHandler1
	Menu, SubBaxMenuTG, Icon, T-Jah Tom @BaxterWorks, Grafix\bax.ico,1     
	Menu, SubBaxMenuTG, Add, BaxterWorks Stickerpacks, TGHandler2
	Menu, SubBaxMenuTG, Add
	Menu, SubBaxMenuTG, Add, BaxterWorks_Bot, TGHandler3
	Menu, SubBaxMenuTG, Add, Tom's Knecht, TGHandler4
	Menu, SubBaxMenuTG, Add, GTA Werkstattmeister, TGHandler5
	Menu, SubBaxMenuTG, Add, Helferlein, TGHandler6
	Menu, SubBaxMenuTG, Add
	Menu, SubBaxMenuTG, Add, Hanfkanal, TGHandler7
	Menu, SubBaxMenuTG, Add, VfL Bochum Gruppe, TGHandler8
	Menu, SubBaxMenuTG, Add, Reggae Kanal, TGHandler9
	Menu, SubBaxMenuTG, Add, FMS Gruppe, TGHandler10
; Erstellt die erste Stufe Untermenü (mit einem nach rechts gerichteten Pfeil). Sobald der Benutzer dieses Untermenü auswählt, wird das zweite Menü angezeigt.
	Menu, BaxMenu, Add, BaxterWorks Tools starten, :SubBaxMenuBW			; Untermenü BW
	Menu, BaxMenu, Icon, BaxterWorks Tools starten, Grafix\bax.ico,1     
	Menu, BaxMenu, Add, Hilfetexte, :SubBaxMenuHelp				; Untermenü Hilfe
	Menu, BaxMenu, Icon, Hilfetexte, C:\WINDOWS\System32\SHELL32.dll,225     
	Menu, BaxMenu, Add, Versionsinfos, :SubBaxMenuVersion			; Untermenü Whats new
	Menu, BaxMenu, Icon, Versionsinfos, C:\WINDOWS\System32\SHELL32.dll,278     
	Menu, BaxMenu, Add, Telegram Messenger, :SubBaxMenuTG			; Untermenü Telegram
	Menu, BaxMenu, Icon, Telegram Messenger, Grafix\telegram.ico,1     
; Erstellt die untersten Einträge der ersten Oberfläche
	Menu, BaxMenu, Add  							; Fügt eine Trennlinie unterhalb des Untermenüs ein.
	Menu, BaxMenu, Add,  GetReadyBax - Konfiguration, ConfigMenu
	Menu, BaxMenu, Icon, GetReadyBax - Konfiguration,  Grafix\runaway.ico,1     
	Menu, BaxMenu, Add, About, AboutMenuSub  				; Fügt einen weiteren Menüpunkt unterhalb des Untermenüs ein.
	Menu, BaxMenu, Icon, About, C:\WINDOWS\System32\SHELL32.dll,222
return  ; Ende des automatischen Ausführungsbereichs.


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Traymenü                    [Version 001]   +                                                       │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

TRAYMENU:
Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray,NoMainWindow
Menu,Tray,Add,%AppName%,About
Menu,Tray,Add						; Trennlinie
Menu,Tray,Add,Licence...,Licence
Menu,Tray,Add,Credits...,Credits
Menu,Tray,Add,About...,About
Menu,Tray,Add,Hilfe...,HilfeTray
Menu,Tray,Add						; Trennlinie
Menu,Tray,Add,Variablen...,Variablen
Menu,Tray,Add,HotKeys...,HotKeys
Menu,Tray,Add,Reload...,Reload
Menu,Tray,Add
Menu,Tray,Add,Konfiguration mit GetReadyBax,GetReadyTray
Menu,Tray,Add,Tools laden,Apps						; Trennlinie
Menu,Tray,Add,Settings...,EINSTELLUNGEN
Menu,Tray,Add,Neuerungen...,Version
Menu,Tray,Add,Exit,EXIT
Menu,Tray,Tip,%AppName% %Codeversion%
Menu,Tray,Default,%AppName%
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Includes, nur dieses Skript    [Version 002]   +                                                         │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Apps und HK
	#Include %A_ScriptDir%\HotKeys\hk_appstart.ahk
	#Include %A_ScriptDir%\HotKeys\hk_editbax.ahk
	#Include %A_ScriptDir%\HotKeys\hs_edittom.ahk
	#Include %A_ScriptDir%\HotKeys\listbax.ahk

; BaxFunk Module
	#Include %A_ScriptDir%\Function\BaxFunk_FensterInfo.ahk	
	#Include %A_ScriptDir%\Function\BaxFunk_LicenceWindow.ahk	
	#Include %A_ScriptDir%\Function\BaxFunk_2Win.ahk
	#Include %A_ScriptDir%\Function\BaxFunk_Dropper.ahk
	#Include %A_ScriptDir%\Function\BaxFunk_ConfigWindow.ahk
	#Include %A_ScriptDir%\Function\BaxFunk_reloadAHK.ahk

	#Include %A_ScriptDir%\Function\FileInstall.ahk

; ThirdParty
	#Include %A_ScriptDir%\Lib\Class_CTLCOLORS.ahk
	#Include %A_ScriptDir%\Lib\datecalc.ahk
	#Include %A_ScriptDir%\Lib\DayofDate.ahk
	#Include %A_ScriptDir%\Lib\Functions.ahk
	#Include %A_ScriptDir%\Lib\funk_panic.ahk
	#Include %A_ScriptDir%\Lib\funk_toggle.ahk
	#Include %A_ScriptDir%\Lib\Gdip_all.ahk
	#Include %A_ScriptDir%\Lib\ipfindmap.ahk
	#Include %A_ScriptDir%\Lib\keepalive.ahk
	#Include %A_ScriptDir%\Lib\MouseisOver.ahk
	#Include %A_ScriptDir%\Lib\ObjCSV.ahk
	#Include %A_ScriptDir%\Lib\toggle_hiddenfiles.ahk
	#Include %A_ScriptDir%\Lib\toggle_lightdark.ahk
	#Include %A_ScriptDir%\Lib\tf.ahk
	#Include %A_ScriptDir%\Lib\tts.ahk
	#Include %A_ScriptDir%\Lib\UrlDownloadToVar.ahk
	#Include %A_ScriptDir%\Lib\VA.inc.ahk

	#Include %A_ScriptDir%\HotKeys\AutoCorrect.ahk
	#Include %A_ScriptDir%\HotKeys\hk_appstart.ahk
	#Include %A_ScriptDir%\HotKeys\ifexist_notepad.ahk
	#Include %A_ScriptDir%\HotKeys\tv_ahk.ahk
	#Include %A_ScriptDir%\HotKeys\tv_md.ahk
	#Include %A_ScriptDir%\HotKeys\tv_txt.ahk




; On Shutdown (siehe oben)
	SaveSettings() {
	MsgBox, Viele Apps speichern beim Beenden DEINE Eingaben. Besser erst die Programme beenden - dann runterfahren.`nT-Jah Tom
	GoSub, EXIT
	}

;-----------------------------------------------------------------(Ende Autoexec) 

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
Gui,99:Add,Text, R3 ,BaxterWorks ist die Struktur für einige Tools und Funktionen.`nDie Software erweitert deinen PC`nBeachte die Hilfetexte
Gui,99:Font,cBlue bold Underline
Gui,99:Add,Text,R1 gBWApp,www.baxterworks.de/software
Gui,99:Font

Gui,99:Add,Picture,xs w70 h70 Icon1,%A_ScriptDir%\Grafix\BW_Software.ico
Gui,99:Font,Bold
Gui,99:Font, s10 cBlack, Verdana
Gui,99:Add,Text, R1 xp+100 ,%Firma%
Gui,99:Font
Gui,99:Font, s9 cBlack, Verdana
Gui,99:Add,Text,R3 ,Auf der Webseite findest du weitere Apps,`nein paar Codeschnippsel und Informationen`nzur Software.
Gui,99:Font,CBlue bold Underline
Gui,99:Add,Text,y+5 gBWSoft,www.baxterworks.de/software
Gui,99:Font

Gui,99:Add,Picture,xs w70 h70 Icon1,%A_ScriptDir%\Grafix\bax.ico
Gui,99:Font,Bold
Gui,99:Font, s10 cBlack, Verdana
Gui,99:Add,Text, R1 xp+100 ,Blog BaxterWorks
Gui,99:Font
Gui,99:Font, s9 cBlack, Verdana
Gui,99:Add,Text,R3 ,Die ungefragte Meinung`nIn unregelmäßigen Abständen melde ich mich dort zu Wort.`nMöglichkeit der Kontaktaufnahme ist gegeben.
Gui,99:Font,CBlue bold Underline
Gui,99:Add,Text,y+5 gBWBlog,blog.baxterworks.de
Gui,99:Font

Gui,99:Add,Picture,xs w70 h70 Icon1,%A_ScriptDir%\Grafix\ahk.ico
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
; │   Funktion dieses Skript    [Version 001]                                                                  │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs BaxMenu    [Version 001]  			                                                       │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

;--------------------------------------------------------------------------------------Menüpunkte 1.Ebene
HKHandler1:
	send, ^2
	return
HKHandler2:
	whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	whr.Open("GET", "https://pastebin.com/raw/wYGqAsYk", true)
	whr.Send()
	; Using 'true' above and the call below allows the script to remain responsive.
	whr.WaitForResponse()
	version := whr.ResponseText
	clipboard := ""   ; Leert die Zwischenablage.	; edit by T-Jah Tom 06/2021
	clipboard := whr.ResponseText
	Run, %A_WinDir%\notepad.exe
	WinWait, Unbenannt - Editor,, 3
	if ErrorLevel
{
	MsgBox, WinWait hat das Zeitlimit überschritten.
	return
}
	else
    	WinGetPos, X, Y, W, H
	WinMove, Unbenannt - Editor, , 0, 100, 1000, 800
	WinSetTitle, BaxterWorks ListBax			; Titel verschwindet wieder
	WinSet, AlwaysOnTop, On
	send,^v
	return

ConfigMenu:
	run,%Bax_Start%\Apps\GetReadyBax\GetReadyBax.exe
	return

AboutMenuSub:
	MsgBox, %AppName% %codeversion%`nBaxterWorks Software`n(c) 1999-2021 T-Jah Tom
	return
;--------------------------------------------------------------------------------------Menüpunkte BW Apps

SubsBWHandler1:
	run, %Bax_Start%\Apps\BWAppBar\BWAppBar.exe
	return
SubsBWHandler2:
	run, %Bax_Start%\Apps\BWAppBar\00AppBar.exe
	return
SubsBWHandler3:
	run, %Bax_Start%\Apps\CaptureBax\CaptureBax.exe
	return
SubsBWHandler4:
	run, %Bax_Start%\Apps\DesktopPainter\DesktopPainter.exe
	return
SubsBWHandler5:
	run, %Bax_Start%\Apps\Emoji\EmojiMenu.exe
	return
SubsBWHandler6:
	run, %Bax_Start%\Apps\FavFolder\FavoriteFolders.exe
	return
SubsBWHandler7:
	run, %Bax_Start%\Apps\IconExctract\IconExctractor.exe
	return
SubsBWHandler8:
	run, %Bax_Start%\Apps\KillerBax\KillerBax.exe
	return
SubsBWHandler9:
	run, %Bax_Start%\Apps\Launcher\AppBoard.exe
	return
SubsBWHandler10:
	run, %Bax_Start%\Apps\Lupe\MagnifyBax.exe
	return
SubsBWHandler11:
	run, %Bax_Start%\Apps\MiniDBs\MiniDB.exe
	return
SubsBWHandler12:
	run, %Bax_Start%\Apps\NumpadZeichner\NumpadZeichner.exe
	return
SubsBWHandler13:
	run, %Bax_Start%\Apps\SuchBax\SuchBax.exe
	return
SubsBWHandler14:
	run, %Bax_Start%\Apps\UhrDigiSimple\UhrDigiSimple.exe
	return

;--------------------------------------------------------------------------------------Menüpunkte Hilfetexte
SubsHilfeHandler1:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help.htm, %Bax_Start%\Files\help.htm
	}
	run,%Bax_Start%\Files\help.htm
	return

SubsHilfeHandler2:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_bwappbar.htm, %Bax_Start%\Files\help_bwappbar.htm
	}
	run,%Bax_Start%\Files\help_bwappbar.htm
	return

SubsHilfeHandler3:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_hotkeys.htm, %Bax_Start%\Files\help_hotkeys.htm
	}
	run,%Bax_Start%\Files\help_hotkeys.htm
	return

;--------------------------------------------------------------------------------------Menüpunkte Versionsinfos

SubsMenuVersioninfo1:
	Run, %Bax_Start%\Log\Versionsinfo.txt
	return
SubsMenuVersioninfo2:
	Run, %Bax_Start%\Log\Versionsinfo_BWAppBar.txt
	return
SubsMenuVersioninfo3:
	Run, %Bax_Start%\Log\Versionsinfo_00AppBar.txt
	return
SubsMenuVersioninfo4:
	Run, %Bax_Start%\Log\Versionsinfo_00AppBar.txt
	return
SubsMenuVersioninfo5:
	Run, %Bax_Start%\Log\Versionsinfo_00AppBar.txt
	return
SubsMenuVersioninfo6:
	Run, %Bax_Start%\Log\Versionsinfo_00AppBar.txt
	return

;--------------------------------------------------------------------------------------Menüpunkte Telegram

TGHandler1:
	run, https://t.me/BaxterWorks
	return

TGHandler2:
	run, http://simp.ly/p/Swj4NH
	return

TGHandler3:
	run, https://t.me/BaxterWorks_Bot
	return

TGHandler4:
	run, https://t.me/Tom_sein_Bot
	return

TGHandler5:
	run, https://t.me/GTA_cars_bot
	return

TGHandler6:
	run, https://t.me/Helferlein_OFG_Bot
	return

TGHandler7:
	run, https://t.me/Hanfkanal
	return

TGHandler8:
	run, https://t.me/VfL_Freunde
	return

TGHandler9:
	run, https://t.me/DreadyT
	return

TGHandler10:
	run, https://t.me/FMS_Gruppe
	return




^1::Menu, BaxMenu, Show  ; Drücken Sie STRG+1, um das Menü anzuzeigen.
RMenu:
	Menu, BaxMenu, Show

;-----------------------------------------------------Ende BaxMenu


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs Traymenü    [Version 0xx]   Pfade nicht Standard                                                    │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

GetReadyTray:
	run, %Bax_Start%\Apps\GetReadyBax\GetReadyBax.exe
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
	Bax_ConfigGui_Create()
	return

EINSTELLUNGEN:
	Run,%scriptini%
	Return

Variablen:
	ListVars
	return

Version:
	Run,%A_ScriptDir%\Log\Versionsinfo.txt
	return
HotKeys:
	ListHotkeys
	return

Reload:
	reload
	return

OpenGUI:
	Goto,About
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
; │   Sub Ini  [Version 002]                                                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
; hier einfügen, was der User an Vars setzen kann

INIREAD:
IniRead, Bax_Start , %homeini%, FixVars, Bax_Start
IniRead, homeini , %homeini%, FixVars, homeini
IniRead, userini , %homeini%, FixVars, userini
IniRead, Bax_Bar , %homeini%, FixVars, Bax_Bar
IniRead, Bax_IP , %homeini%, Netzinfo, Letzte IP
IniRead, PCName , %homeini%, FixVars, PCName
IniRead, FensterVersion , %homeini%, FixVars, FensterVersion
IniRead, Ziel1, %userini%, Dropper, Ziel1, %A_Space% 
IniRead, Ziel2, %userini%, Dropper, Ziel2, %A_Space% 
IniRead, DeinOrdner1, %userini%, 2Win, DeinOrdner1, %A_Space% 
IniRead, DeinOrdner2, %userini%, 2Win, DeinOrdner2, %A_Space% 
IniRead, Bax_JobDir, %userini%, Variablen, Bax_JobDir, %A_Space% 
IniRead, Bax_Flex, %userini%, Variablen, Bax_Flex, %A_Space% 
IniRead, LastVersionBW, %userini%, Variablen, LastVersionBW, %A_Space% 

return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   EndSub          [Version 002]    ohneGUI  + Pfade nicht Standard                                         │
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
MenuEnde:
DateiBeenden:     		; Benutzer hat "Exit" im Dateimenü ausgewählt.
	INIWRITE:
		IniWrite, %LetzteAnmeldung% , %userini%, Nutzerinfo, Letzter Nutzer
		IniWrite, %LetzterEinsatz% , %userini%, Nutzerinfo, Letzter Rechner
		IniWrite, %CodeVersion% , %userini%, Nutzerinfo, LastVersionBW
		

ButtonCancel:			; falls es einen Button gibt
GuiEscape:
GuiClose:
CleanUp:
	SoundBeep, 750, 500
  	CTLCOLORS.Free()		; wenn classCTLColours benutzt wurde
	Gdip_Shutdown(pToken)		; wird in includes gestartet

	if FileExist("Files\*.htm")
	FileDelete %A_ScriptDir%\Files\*.htm

ExitApp
