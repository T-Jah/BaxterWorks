CodeVersion := "1.0.7.3", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\Grafix\bax.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription Tools und Skripte
;@Ahk2Exe-SetFileVersion 1.0.7.3
;@Ahk2Exe-SetProductVersion 1.0.7.3
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
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 030          M.u.s.t.e.r.Bax AHK Skript
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
 * │   Skriptoptionen 	MusterBax              [Version 005]        +                                           │
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
; Set Lock keys permanently - nur im ersten Skipt aufrufen (Tom)
	SetNumlockState, AlwaysOn	
	SetCapsLockState, AlwaysOff
	SetScrollLockState, AlwaysOff
; Icon
	Menu Tray, Icon, %A_ScriptDir%\Grafix\bax.ico	; #NoTrayIcon

; OnExit
	#Include %A_ScriptDir%\Function\BaxFunk_Exit.ahk

; OnError
	OnError("FehlerProtokollieren")
	Fehler := auslösen

	FehlerProtokollieren(Exception) {
    	FileAppend % "Fehler bei Zeile " Exception.Line ": " Exception.Message "`n" , FehlerBax.txt
    	return true
	}


;---------------------------------------------------------------------------------------------------------------

;┌────────────────────────────────────┐
;│ Teil1:                             │
;│   - erste Variablen setzen         │
;│   - zur Info in ini schreiben      │
;│   - die AppBar wird vorbereitet    │
;│   - Erster Start? Ab zur config    │
;│   - oder weiter im Skript          │
;└────────────────────────────────────┘

;----------------------------------------------------------------------------------------------
; msgbox, 4, BaxterWorks Software Testing, BaxterWorks Skriptcheck 001 , 3
;----------------------------------------------------------------------------------------------

; Startumgebungsvariablen festlegen
	AppName = BaxterWorks
	Bax_help = help
	FensterVersion = MusterBax_030		; aktuelle Vorlage und Module
	Skriptvorlage = MusterBax_030		; eingesetzte Version und Vorlage
	Bax_Bar = %A_Appdata%\Microsoft\Internet Explorer\Quick Launch
	LastVersionBW = %CodeVersion%
	BaxNutzerName = %A_UserName%_%A_ComputerName%
	FormatTime, LastSeen,, LongDate
	LastSeen = %LastSeen%
	UhrStart = %A_Now%
	LastLogIn = %A_Now%_%AppName%
	LastLogInZeit = %A_Now%

	Bax_Start = %A_ScriptDir%
	Bax_exe = %Bax_Start%\BaxterWorks.exe
	Bax_Icon = %Bax_Start%\Grafix\bax.ico
	homeini = %Bax_Start%\Config\BaxterWorks.ini
	userini = %Bax_Start%\Config\%BaxNutzerName%.ini
	scriptini = %Bax_Start%\Config\%AppName%.ini
	backuptxt = %Bax_Start%\Log\%BaxNutzerName%.txt
	
; Alte Werte zurücksetzen, laden und beim beenden speichern
	LastSeen_davor =
	UhrStart_davor =

	IniWrite, %BaxNutzerName% , %userini%, %A_UserName%_%A_ComputerName%, BaxNutzerName
	IniRead, LastSeen_davor , %userini%, %BaxNutzerName% , %LastSeen%
	IniRead, UhrStart_davor , %userini%, %BaxNutzerName% , %UhrStart%
	
	LastSeen_davor = %LastSeen%
	UhrStart_davor = %UhrStart%

; Startumgebungsvariablen erfassen
	LetzteAnmeldung = %A_UserName%
	LetzterEinsatz = %A_ComputerName%

; Startumgebungsvariablen in homeini (BaxterWorks) schreiben, wird von allen Skripten gelesen
	IniDelete, %homeini%, FixVars, 
	IniWrite, %A_ScriptDir% , %homeini%, FixVars, Bax_Start
	IniWrite, %Bax_Start%\Config\BaxterWorks.ini , %homeini%, FixVars, homeini
	IniWrite, %userini% , %homeini%, FixVars, userini
	IniWrite, %A_Appdata%\Microsoft\Internet Explorer\Quick Launch , %homeini%, FixVars, Bax_Bar
	IniWrite, %Bax_exe% , %homeini%, FixVars, Bax_exe
	IniWrite, %FensterVersion% , %homeini%, FixVars, FensterVersion
	IniWrite, %Skriptvorlage% , %homeini%, FixVars, Skriptvorlage
	IniWrite, %backuptxt% , %homeini%, FixVars, backuptxt
	IniWrite, %A_Now%_%AppName% , %scriptini%, Stats_%BaxNutzerName% , LastLogIn
	IniWrite, %A_Now% , %scriptini%, Stats_%BaxNutzerName% , LastLogInZeit



;----------------------------------------------------------------------------------------------
; msgbox, 4, BaxterWorks Software Testing, %LastSeen% und %UhrStart%, 5
;----------------------------------------------------------------------------------------------


; Das Menü der AppBar wird gecheckt, bzw das Symbol des Menüs
	if !FileExist("%Bax_Bar%\00AppBar.lnk")
	FileCreateShortcut, %Bax_Start%\Apps\BWAppBar\00AppBar.exe, %Bax_Bar%\00AppBar.lnk, %Bax_Start%, "%A_ScriptFullPath%", Menü mit Rechtsklick oder WIN+Z, %Bax_Start%\Grafix\menuico.ico,   

; Das Symbol für BaxterWorks wird gecheckt
	if !FileExist("%Bax_Bar%\01_BaxterWorks.lnk")
	FileCreateShortcut, %Bax_Start%\BaxterWorks.exe, %Bax_Bar%\01_BaxterWorks.lnk, %Bax_Start%, "%A_ScriptFullPath%", Menü mit Rechtsklick oder WIN+Z, %Bax_Start%\Grafix\bax.ico,   
   

; Erster Start? Pfade müssen gesetzt werden mit einer ExtraApp

if !FileExist("%Bax_Start%\Config\%BaxNutzerName%.ini")
	Loop, read, %userini%    ; die gesamtzahl der zeilen ermitteln
        lineMax++
	if lineMax > 15
	GoTo, 2ndstep
	else {
; öffnet GetReadyBax.exe
	MsgBox, Hallo`nIch habe die Aufgabe ein paar Variablen zu füllen - besser du.`nDas macht Arbeit. Aber es gibt dir die Möglichkeit`ndeine Vorlieben einzugeben die ich nicht kennen kann.`n`nEine Datei wurde gelöscht oder noch nicht erstellt oder nicht zu Ende bearbeitet.`nDu wirst zur Konfiguration gezw..beten.`nNimm Dir einen Moment Zeit. Die Eingaben sind von`nzentraler Bedeutung für den Nutzen dieser Anwendung.
	
	firstseen = %A_Now%
	FileAppend, ErstNutzung: %A_Now% %A_Tab% Nutzer: %BaxNutzerName%  %A_Tab% App: %AppName%`n , %Bax_Start%\Config\%A_ComputerName%.bax
	IniWrite, %firstseen% , %userini%, %BaxNutzerName% , Erstnutzung
	run, %Bax_Start%\Apps\GetReadyBax\GetReadyBax.exe
	GoTo,Configzwang
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
;----------------------------------------------------------------------------------------------
; msgbox, 4, BaxterWorks Software Testing, BaxterWorks Skriptcheck 002 Teil2 , 3
;----------------------------------------------------------------------------------------------

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

;------AppBarcheck-----------------------------------------------------

	if !WinExist("ahk_exe BWAppBar.exe")
	;MsgBox, AppBar ist nicht an %Bax_Start%
	Run, %Bax_Start%\Apps\BWAppBar\BWAppBar.exe


;┌──────────────────────────────────────────┐
;│ Teil3:                                   │
;│   - Ini Dateien  			    │
;│   - TrayMenü				    │
;│   - AboutFenster			    │
;│   - Includes       			    │
;│   -  		        	    │
;└──────────────────────────────────────────┘

; Versionscheck
	IniRead, LastVersionBW, %homeini%, SkriptInfo, LastVersionBW
	If (LastVersionBW != CodeVersion)
	Run, notepad.exe %Bax_Start%\Log\Versionsinfo.txt

; Toolstartcheck
	#Include %A_ScriptDir%\Function\BaxFunk_appcheck.ahk	
		BaxFunk_toolstart()


;--------------- Ende AutoExecBereich
;----------------------------------------------------------------------------------------------
; msgbox, 4, BaxterWorks Software Testing, BaxterWorks Skriptcheck Ende AutoExec , 3
;----------------------------------------------------------------------------------------------

; Gute Stelle, um noch mehr Variablen zu laden
	GoSub, INIREAD		; aus IniFiles lesen
	GoSub, BaxMenu		; erstellt das STRG+1 Menü
	GoSub, TRAYMENU		; dann noch das TrayMenü
	GoSub, CountBax		; ein einfacher Zähler
	GoSub, Stats		; eine simple Statistik Funktion


; Wichtige HK (nur in diesem Skript, deswegen an dieser Stelle
	#Include %A_ScriptDir%\Function\BaxFunk_Keys.ahk


^1::Menu, BaxMenu, Show  ; Drücken Sie STRG+1, um das Menü anzuzeigen.



	GoSub, IncludeBax	; integriert Hotkeys und Funktionen

return
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
	Menu, SubBaxMenuBW, Add, DesktopPainter, SubsBWHandler4
	Menu, SubBaxMenuBW, Icon, DesktopPainter, Grafix\pic.ico,1     
	Menu, SubBaxMenuBW, Add, EmojiMenu, SubsBWHandler5
	Menu, SubBaxMenuBW, Icon, EmojiMenu, Grafix\cool.ico,1     
	Menu, SubBaxMenuBW, Add, FavoriteFolders, SubsBWHandler6
	Menu, SubBaxMenuBW, Icon, FavoriteFolders, Grafix\ordner3.ico,1     
	Menu, SubBaxMenuBW, Add, IconExtractor, SubsBWHandler7
	Menu, SubBaxMenuBW, Icon, IconExtractor, Grafix\linux.ico,1     
	Menu, SubBaxMenuBW, Add, KillerBax, SubsBWHandler8
	Menu, SubBaxMenuBW, Icon, KillerBax, Grafix\killerbax.ico,1     
	Menu, SubBaxMenuBW, Add, AppBoard, SubsBWHandler9
	Menu, SubBaxMenuBW, Icon, AppBoard, Grafix\logo_tjah.ico,1     
	Menu, SubBaxMenuBW, Add, MiniDBs, SubsBWHandler11
	Menu, SubBaxMenuBW, Icon, MiniDBs, Grafix\fledermond2.ico,1     
	Menu, SubBaxMenuBW, Add, NumpadZeichner, SubsBWHandler12
	Menu, SubBaxMenuBW, Icon, NumpadZeichner, Grafix\npz.ico,1     
	Menu, SubBaxMenuBW, Add, SuchBax, SubsBWHandler13
	Menu, SubBaxMenuBW, Icon, SuchBax, Grafix\welt.ico,1     
	Menu, SubBaxMenuBW, Add, Digitaluhr, SubsBWHandler14
	Menu, SubBaxMenuBW, Icon, Digitaluhr, Grafix\uhr3.ico,1     
	Menu, SubBaxMenuBW, Add, neArtWürfel, SubsBWHandler15
	Menu, SubBaxMenuBW, Icon, neArtWürfel, Grafix\wuerfel.ico,1     
; Einträge Untermenü Hilfe
	Menu, SubBaxMenuHelp, Add, Hilfetexte HotKeys, SubsHilfeHandler3
	Menu, SubBaxMenuHelp, Icon, Hilfetexte HotKeys, Grafix\klee.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte Dateimenü, SubsHilfeHandler15
	Menu, SubBaxMenuHelp, Icon, Hilfetexte Dateimenü, Grafix\menuico.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte AppBoard, SubsHilfeHandler9
	Menu, SubBaxMenuHelp, Icon, Hilfetexte AppBoard, Grafix\logo_tjah.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte BaxterWorks, SubsHilfeHandler1
	Menu, SubBaxMenuHelp, Icon, Hilfetexte BaxterWorks, Grafix\bax.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte BWAppBar, SubsHilfeHandler2
	Menu, SubBaxMenuHelp, Icon, Hilfetexte BWAppBar, Grafix\appbar.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte 00AppBar, SubsHilfeHandler2
	Menu, SubBaxMenuHelp, Icon, Hilfetexte 00AppBar, Grafix\menuico.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte CaptureBax, SubsHilfeHandler16
	Menu, SubBaxMenuHelp, Icon, Hilfetexte CaptureBax, Grafix\schere.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte DesktopPainter, SubsHilfeHandler4
	Menu, SubBaxMenuHelp, Icon, Hilfetexte DesktopPainter, Grafix\pic.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte EmojiMenu, SubsHilfeHandler5
	Menu, SubBaxMenuHelp, Icon, Hilfetexte EmojiMenu, Grafix\cool.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte FavoriteFolders, SubsHilfeHandler6
	Menu, SubBaxMenuHelp, Icon, Hilfetexte FavoriteFolders, Grafix\ordner3.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte GetReadyBax, SubsHilfeHandler8
	Menu, SubBaxMenuHelp, Icon, Hilfetexte GetReadyBax, Grafix\runaway.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte IconExtractor, SubsHilfeHandler7
	Menu, SubBaxMenuHelp, Icon, Hilfetexte IconExtractor, Grafix\linux.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte KillerBax, SubsHilfeHandler10
	Menu, SubBaxMenuHelp, Icon, Hilfetexte KillerBax, Grafix\KillerBax.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte MiniDBs, SubsHilfeHandler11
	Menu, SubBaxMenuHelp, Icon, Hilfetexte MiniDBs, Grafix\fledermond2.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte NumpadZeichner, SubsHilfeHandler12
	Menu, SubBaxMenuHelp, Icon, Hilfetexte NumpadZeichner, Grafix\npz.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte SuchBax, SubsHilfeHandler13
	Menu, SubBaxMenuHelp, Icon, Hilfetexte SuchBax, Grafix\welt.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte UhrDigiSimple, SubsHilfeHandler14
	Menu, SubBaxMenuHelp, Icon, Hilfetexte UhrDigiSimple, Grafix\uhr3.ico,1     
	Menu, SubBaxMenuHelp, Add, Hilfetexte neArtWürfel, SubsHilfeHandler1
	Menu, SubBaxMenuHelp, Icon, Hilfetexte neArtWürfel, Grafix\wuerfel.ico,1     
; Einträge Untermenü Versionsinfo
	Menu, SubBaxMenuVersion, Add, Versionsinfo AppBoard, SubsMenuVersioninfo9
	Menu, SubBaxMenuVersion, Icon, Versionsinfo AppBoard, Grafix\logo_tjah.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo BaxterWorks, SubsMenuVersioninfo1
	Menu, SubBaxMenuVersion, Icon, Versionsinfo BaxterWorks, Grafix\bax.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo BWAppBar, SubsMenuVersioninfo2
	Menu, SubBaxMenuVersion, Icon, Versionsinfo BWAppBar, Grafix\appbar.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo 00AppBar, SubsMenuVersioninfo3
	Menu, SubBaxMenuVersion, Icon, Versionsinfo 00AppBar, Grafix\menuico.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo CaptureBax, SubsMenuVersioninfo15
	Menu, SubBaxMenuVersion, Icon, Versionsinfo CaptureBax, Grafix\schere.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo DesktopPainter, SubsMenuVersioninfo4
	Menu, SubBaxMenuVersion, Icon, Versionsinfo DesktopPainter, Grafix\pic.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo EmojiMenu, SubsMenuVersioninfo5
	Menu, SubBaxMenuVersion, Icon, Versionsinfo EmojiMenu, Grafix\cool.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo FavoriteFolders, SubsMenuVersioninfo6
	Menu, SubBaxMenuVersion, Icon, Versionsinfo FavoriteFolders, Grafix\ordner3.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo GetReadyBax, SubsMenuVersioninfo8
	Menu, SubBaxMenuVersion, Icon, Versionsinfo GetReadyBax, Grafix\runaway.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo IconExtractor, SubsMenuVersioninfo7
	Menu, SubBaxMenuVersion, Icon, Versionsinfo IconExtractor, Grafix\linux.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo KillerBax, SubsMenuVersioninfo10
	Menu, SubBaxMenuVersion, Icon, Versionsinfo KillerBax, Grafix\killerbax.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo MiniDBs, SubsMenuVersioninfo11
	Menu, SubBaxMenuVersion, Icon, Versionsinfo MiniDBs, Grafix\fledermond2.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo NumpadZeichner, SubsMenuVersioninfo12
	Menu, SubBaxMenuVersion, Icon, Versionsinfo NumpadZeichner, Grafix\npz.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo SuchBax, SubsMenuVersioninfo13
	Menu, SubBaxMenuVersion, Icon, Versionsinfo SuchBax, Grafix\welt.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo UhrDigiSimple, SubsMenuVersioninfo14
	Menu, SubBaxMenuVersion, Icon, Versionsinfo UhrDigiSimple, Grafix\uhr3.ico,1     
	Menu, SubBaxMenuVersion, Add, Versionsinfo neArtWürfel, SubsMenuVersioninfo16
	Menu, SubBaxMenuVersion, Icon, Versionsinfo neArtWürfel, Grafix\wuerfel.ico,1     
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
return


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
Menu,Tray,Tip,%AppName% %CodeVersion%
Menu,Tray,Default,%AppName%

;----------------------------------------------------------------------------------------------
; msgbox, 4, BaxterWorks Software Testing, BaxterWorks Skriptcheck 004 Traymenü , 3
;----------------------------------------------------------------------------------------------

return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Includes, nur dieses Skript    [Version 002]   +                                                         │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

IncludeBax:
;----------------------------------------------------------------------------------------------
; msgbox, 4, BaxterWorks Software Testing, BaxterWorks Skriptcheck 006 Beginn Includes , 3
;----------------------------------------------------------------------------------------------

; Apps und HK
	#Include %A_ScriptDir%\HotKeys\hk_editbax.ahk
	#Include %A_ScriptDir%\HotKeys\hs_edittom.ahk
	#Include %A_ScriptDir%\HotKeys\listbax.ahk
	#Include %A_ScriptDir%\HotKeys\ifexist_notepad.ahk
	#Include %A_ScriptDir%\HotKeys\tv_ahk.ahk
	#Include %A_ScriptDir%\HotKeys\tv_htm.ahk
	#Include %A_ScriptDir%\HotKeys\tv_md.ahk
	#Include %A_ScriptDir%\HotKeys\tv_txt.ahk
	#Include %A_ScriptDir%\HotKeys\hk_appstart.ahk

; BaxFunk Module
	#Include %A_ScriptDir%\Function\BaxFunk_FensterInfo.ahk	
	#Include %A_ScriptDir%\Function\BaxFunk_LicenceWindow.ahk	
	#Include %A_ScriptDir%\Function\BaxFunk_2Win.ahk
	#Include %A_ScriptDir%\Function\BaxFunk_Dropper.ahk
	#Include %A_ScriptDir%\Function\BaxFunk_ConfigWindow.ahk
	#Include %A_ScriptDir%\Function\BaxFunk_Progress.ahk
	#Include %A_ScriptDir%\Function\BaxFunk_reloadAHK.ahk
	#Include %A_ScriptDir%\Function\BaxFunk_Stats.ahk
	#Include %A_ScriptDir%\Function\BaxFunk_VarSchau.ahk

; ThirdParty
	#Include %A_ScriptDir%\Lib\AHKsock.ahk
	#Include %A_ScriptDir%\Lib\Class_CTLCOLORS.ahk
	#Include %A_ScriptDir%\Lib\datecalc.ahk
	#Include %A_ScriptDir%\Lib\Functions.ahk
	#Include %A_ScriptDir%\Lib\funk_panic.ahk
	#Include %A_ScriptDir%\Lib\funk_toggle.ahk
	#Include %A_ScriptDir%\Lib\Gdip_all.ahk
	#Include %A_ScriptDir%\Lib\ipfindmap.ahk
	#Include %A_ScriptDir%\Lib\JSON.ahk
	#Include %A_ScriptDir%\Lib\keepalive.ahk
	#Include %A_ScriptDir%\Lib\MouseisOver.ahk
	#Include %A_ScriptDir%\Lib\ObjCSV.ahk
	#Include %A_ScriptDir%\Lib\toggle_hiddenfiles.ahk
	#Include %A_ScriptDir%\Lib\toggle_lightdark.ahk
	#Include %A_ScriptDir%\Lib\tf.ahk
	#Include %A_ScriptDir%\Lib\toolbar.ahk
	#Include %A_ScriptDir%\Lib\tts.ahk
	#Include %A_ScriptDir%\Lib\UrlDownloadToVar.ahk
	#Include %A_ScriptDir%\Lib\VA.inc.ahk

	#Include %A_ScriptDir%\HotKeys\AutoCorrect.ahk
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
Gui,99:Add,Text, R1 xp+100 ,%AppName% - %Firma% - %CodeVersion% 
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
;----------------------------------------------------------------------------------------------
; msgbox, 4, BaxterWorks Software Testing, BaxterWorks Skriptcheck 005 Aboutfenster , 3
;----------------------------------------------------------------------------------------------

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
	MsgBox, %AppName% %U_version%`nBaxterWorks Software`n(c) 1999-2021 T-Jah Tom
	return
;--------------------------------------------------------------------------------------Menüpunkte BW Apps

SubsBWHandler1:
	run, %Bax_Start%\Apps\BWAppBar\BWAppBar.exe, , UseErrorLevel
	return
SubsBWHandler2:
	run, %Bax_Start%\Apps\BWAppBar\00AppBar.exe, , UseErrorLevel
	return
SubsBWHandler3:
	run, %Bax_Start%\Apps\CaptureBax\CaptureBax.exe, , UseErrorLevel
	return
SubsBWHandler4:
	run, %Bax_Start%\Apps\DesktopPainter\DesktopPainter.exe, , UseErrorLevel
	return
SubsBWHandler5:
	run, %Bax_Start%\Apps\Emoji\EmojiMenu.exe, , UseErrorLevel
	return
SubsBWHandler6:
	run, %Bax_Start%\Apps\FavFolder\FavoriteFolders.exe, , UseErrorLevel
	return
SubsBWHandler7:
	run, %Bax_Start%\Apps\IconExctract\IconExctractor.exe, , UseErrorLevel
	return
SubsBWHandler8:
	run, %Bax_Start%\Apps\KillerBax\KillerBax.exe, , UseErrorLevel
	return
SubsBWHandler9:
	run, %Bax_Start%\Apps\Launcher\AppBoard.exe, , UseErrorLevel
	return
SubsBWHandler10:
	;run, %Bax_Start%\Apps\Emoji\EmojiMenu.exe
	return
SubsBWHandler11:
	run, %Bax_Start%\Apps\MiniDB\MiniDBs.exe, , UseErrorLevel
	return
SubsBWHandler12:
	run, %Bax_Start%\Apps\NumpadZeichner\NumpadZeichner.exe, , UseErrorLevel
	return
SubsBWHandler13:
	run, %Bax_Start%\Apps\SuchBax\SuchBax.exe, , UseErrorLevel
	return
SubsBWHandler14:
	run, %Bax_Start%\Apps\UhrDigiSimple\UhrDigiSimple.exe, , UseErrorLevel
	return
SubsBWHandler15:
	run, %Bax_Start%\Apps\Würfel\neArtWürfel.exe, , UseErrorLevel
	return

;--------------------------------------------------------------------------------------Menüpunkte Hilfetexte
SubsHilfeHandler1:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/%Bax_help%.htm, %Bax_Start%\Files\%Bax_help%.htm
	}
	run,%Bax_Start%\Files\%Bax_help%.htm
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
SubsHilfeHandler4:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_deskpaint.htm, %Bax_Start%\Files\help_deskpaint.htm
	}
	run,%Bax_Start%\Files\help_deskpaint.htm
	return
SubsHilfeHandler5:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_emoji.htm, %Bax_Start%\Files\help_emoji.htm
	}
	run,%Bax_Start%\Files\help_emoji.htm
	return
SubsHilfeHandler6:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_favfolders.htm, %Bax_Start%\Files\help_favfolders.htm
	}
	run,%Bax_Start%\Files\help_favfolders.htm
	return
SubsHilfeHandler7:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_iconextract.htm, %Bax_Start%\Files\help_iconextract.htm
	}
	run,%Bax_Start%\Files\help_iconextract.htm
	return
SubsHilfeHandler8:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_getreadybax.htm, %Bax_Start%\Files\help_getreadybax.htm
	}
	run,%Bax_Start%\Files\help_getreadybax.htm
	return
SubsHilfeHandler9:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_appboard.htm, %Bax_Start%\Files\help_appboard.htm
	}
	run,%Bax_Start%\Files\help_appboard.htm
	return
SubsHilfeHandler10:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_killerbax.htm, %Bax_Start%\Files\help_killerbax.htm
	}
	run,%Bax_Start%\Files\help_killerbax.htm
	return
SubsHilfeHandler11:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_minidb.htm, %Bax_Start%\Files\help_minidb.htm
	}
	run,%Bax_Start%\Files\help_minidb.htm
	return
SubsHilfeHandler12:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_numpadzeichner.htm, %Bax_Start%\Files\help_numpadzeichner.htm
	}
	run,%Bax_Start%\Files\help_numpadzeichner.htm
	return
SubsHilfeHandler13:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_suchbax.htm, %Bax_Start%\Files\help_suchbax.htm
	}
	run,%Bax_Start%\Files\help_suchbax.htm
	return
SubsHilfeHandler14:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_uhrdigisimple.htm, %Bax_Start%\Files\help_uhrdigisimple.htm
	}
	run,%Bax_Start%\Files\help_uhrdigisimple.htm
	return
SubsHilfeHandler15:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_menu.htm, %Bax_Start%\Files\help_menu.htm
	}
	run,%Bax_Start%\Files\help_menu.htm
	return
SubsHilfeHandler16:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_capturebax.htm, %Bax_Start%\Files\help_capturebax.htm
	}
	run,%Bax_Start%\Files\help_capturebax.htm
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
	Run, %Bax_Start%\Log\Versionsinfo_DesktopPainter.txt
	return
SubsMenuVersioninfo5:
	Run, %Bax_Start%\Log\Versionsinfo_EmojiMenu.txt
	return
SubsMenuVersioninfo6:
	Run, %Bax_Start%\Log\Versionsinfo_FavoriteFolders.txt
	return
SubsMenuVersioninfo7:
	Run, %Bax_Start%\Log\Versionsinfo_IconExtractor.txt
	return
SubsMenuVersioninfo8:
	Run, %Bax_Start%\Log\Versionsinfo_GetReadyBax.txt
	return
SubsMenuVersioninfo9:
	Run, %Bax_Start%\Log\Versionsinfo_AppBoard.txt
	return
SubsMenuVersioninfo10:
	Run, %Bax_Start%\Log\Versionsinfo_KillerBax.txt
	return
SubsMenuVersioninfo11:
	Run, %Bax_Start%\Log\Versionsinfo_MiniDBs.txt
	return
SubsMenuVersioninfo12:
	Run, %Bax_Start%\Log\Versionsinfo_NumpadZeichner.txt
	return
SubsMenuVersioninfo13:
	Run, %Bax_Start%\Log\Versionsinfo_SuchBax.txt
	return
SubsMenuVersioninfo14:
	Run, %Bax_Start%\Log\Versionsinfo_UhrDigiSimple.txt
	return
SubsMenuVersioninfo15:
	Run, %Bax_Start%\Log\Versionsinfo_CaptureBax.txt
	return
SubsMenuVersioninfo16:
	Run, %Bax_Start%\Log\Versionsinfo_neArtWürfel.txt
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
  	Run,http://blog.baxterworks.de,, Max UseErrorLevel
	Return

AHKlabel:
  	Run,http://www.autohotkey.com,, Min UseErrorLevel
	Return

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Sub Ini  [Version 003]    +  nur in diesem Skript                                                        │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
; hier einfügen, was der User an Vars setzen kann

INIREAD:
IniRead, Ziel1, %userini%, UserVars, Ziel1
IniRead, Ziel2, %userini%, UserVars, Ziel2
IniRead, DeinOrdner1, %userini%, UserVars, DeinOrdner1
IniRead, DeinOrdner2, %userini%, UserVars, DeinOrdner2
IniRead, Bax_JobDir, %userini%, UserVars, Bax_JobDir 
IniRead, Bax_Flex, %userini%, UserVars, Bax_Flex


;----------------------------------------------------------------------------------------------
; msgbox, 4, BaxterWorks Software Testing, BaxterWorks Skriptcheck 003 IniRead , 3
;----------------------------------------------------------------------------------------------

return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   ErrorLevel          [Version 001]                                                                        │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

ErrorLevel:
if (ErrorLevel = "ERROR")
	MsgBox Das Dokument konnte nicht geöffnet werden.

return
; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   EndSub          [Version 010]    ohneGUI  + nicht Standard                                               │
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
Configzwang:
EXIT:
quit:
MenuEnde:
DateiBeenden:     		; Benutzer hat "Exit" im Dateimenü ausgewählt.
	INIWRITE:
	IniWrite, %LetzteAnmeldung% , %userini%, Nutzerinfo, Letzter Nutzer
	IniWrite, %LetzterEinsatz% , %userini%, Nutzerinfo, Letzter Rechner
	IniWrite, %CodeVersion% , %homeini%, SkriptInfo, LastVersionBW
	IniWrite, %CodeVersion% , %backuptxt%, SkriptInfo, LastVersionBW
	IniWrite, %Bax_exe% , %backuptxt%, FixVars, Bax_exe
	IniWrite, %A_ScriptDir% , %backuptxt%, FixVars, Bax_Start
	IniWrite, %Bax_Start%\Config\BaxterWorks.ini , %backuptxt%, FixVars, homeini
	IniWrite, %userini% , %backuptxt%, FixVars, userini
	IniWrite, %A_Appdata%\Microsoft\Internet Explorer\Quick Launch , %backuptxt%, FixVars, Bax_Bar
	IniWrite, %FensterVersion% , %backuptxt%, FixVars, FensterVersion
	IniWrite, %backuptxt% , %backuptxt%, FixVars, backuptxt
	IniWrite, %BaxIP% , %backuptxt%, Netzinfo, Letzte IP
	IniWrite, %Ziel1% , %backuptxt%, UserVars, Ziel1
	IniWrite, %Ziel2% , %backuptxt%, UserVars, Ziel2
	IniWrite, %DeinOrdner1% , %backuptxt%, UserVars, DeinOrdner1
	IniWrite, %DeinOrdner2% , %backuptxt%, UserVars, DeinOrdner2
	IniWrite, %Bax_JobDir% , %backuptxt%, UserVars, Bax_JobDir
	IniWrite, %Bax_Flex% , %backuptxt%, UserVars, Bax_Flex
	IniWrite, %A_UserName%_%A_ComputerName% , %backuptxt%, %BaxNutzerName%, %BaxNutzerName%
	IniWrite, %count% , %backuptxt%, %BaxNutzerName%, %BaxNutzerName%
	IniWrite, %LastSeen% , %backuptxt%, %BaxNutzerName% , LastSeen_davor
	IniWrite, %UhrStart% , %backuptxt%, %BaxNutzerName% , UhrStart_davor
	IniWrite, %LastSeen% , %userini%, %BaxNutzerName% , LastSeen_davor
	IniWrite, %UhrStart% , %userini%, %BaxNutzerName% , UhrStart_davor
	IniWrite, %AppName%_%CodeVersion%_%Skriptvorlage%_%A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzung_%AppName%
	IniWrite, %A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzzeit_%AppName%

	FormatTime, LastSeen,, LongDate
	IniWrite, %LastSeen% , %backuptxt%, %BaxNutzerName% , LastSeen
	IniWrite, %LastSeen% , %userini%, %BaxNutzerName% , LastSeen
	IniWrite, %A_Now% , %backuptxt%, %BaxNutzerName% , UhrStart
	IniWrite, %A_Now% , %userini%, %BaxNutzerName% , UhrStart
FileAppend, Nutzung: %A_Now% %A_Tab% Nutzer: %BaxNutzerName% %A_Tab% App: %AppName%_%CodeVersion% %A_Tab% Skriptvorlage: %Skriptvorlage% %A_Tab% %Appnutzcount% Starts in %Nutzungstage% Tagen`n , %Bax_Start%\Files\Stats\%A_ComputerName%.txt

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
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Zähler      [Version 001]  					                                       │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;
	CountBax:
	IniRead, count, %userini%, %A_UserName%_%A_ComputerName%, %BaxNutzerName%
	FileAppend, %count%, %A_ComputerName%_%A_UserName%.txt
	FileRead, count, %A_ComputerName%_%A_UserName%.txt
	++count
	FileDelete, %A_ComputerName%_%A_UserName%.txt
	FileAppend, %count%, %A_ComputerName%_%A_UserName%.txt
	FileRead, count, %A_ComputerName%_%A_UserName%.txt
	;MsgBox, % count
	IniWrite, %count%, %userini%, %BaxNutzerName%, %BaxNutzerName%
	FileDelete, %A_ComputerName%_%A_UserName%.txt
;----------------------------------------------------------------------------------------------
; msgbox, 4, BaxterWorks Software Testing, BaxterWorks Skriptcheck 005 Zähler , 3
;----------------------------------------------------------------------------------------------

if (count = 1)
	msgbox, 4, BaxterWorks Software informiert, Willkommen und Vielen Dank für dein Vertrauen.`n`nVorab ein Hinweis: Warum der Defender die App ab und zu als`ngefährlich einstuft - versuche ich in der Hilfe zu erklären. Es gibt kein Grund zur Sorge`n Der Quellcode ist offen einsehbar github.com/T-Jah. Das Thema findest du auch im offiziellen Forum.`n`nViel Spaß beim ausprobieren. Strg+1 und Strg+2 sind gute Startaktionen. , 15

if (count = 15)
msgbox, 4, BaxterWorks Software informiert, Vielen Dank für dein Vertrauen. Du hast die App 15 mal gestartet - was nur du lokal weißt`nDer Zähler ist eigentlich nur eine Übung und Info für dich. Mehr zum Thema Daten und wofür die Logdateien sind findest du in der Hilfe. , 15

if (count = 50)
msgbox, 4, BaxterWorks Software informiert, Vielen Dank für dein Vertrauen. Du hast die App 50 mal gestartet - was nur du lokal weißt`nWenn sie dir gefällt magst du mich vielleicht mit einer Tasse Kaffee unterstützen? Vielen Dank für jede Hilfe , 15

if (count = 100)
msgbox, 4, BaxterWorks Software informiert, Vielen Dank für dein Vertrauen. Du hast die App 100 mal gestartet, was nur du lokal weißt`nWenn sie dir gefällt magst du mich vielleicht mit einer Tasse Kaffee unterstützen? Vielen Dank für jede Hilfe. Oh hab ich das schon gesagt? Na gut - du weißt es und ich muss es nicht mehr sagen. Und DANKE , 15

if (count = 250)
msgbox, 4, BaxterWorks Software informiert, Wow. 250 Starts von baxterworks.exe - mehr als ich zu hoffen wagte. Gib mir Feedback über GitHub. Nach so vielen Starts hast du vielleicht wichtige Kritik? Danke. , 15

if (count = 500)
msgbox, 4, BaxterWorks Software informiert, Vielen Dank für dein Vertrauen. Du hast die App 500 mal gestartet - sehr beeindruckend. Das war nun die letzte Meldung dieser Art. Falls du mich unterstützt hast meinen aufrichtigen Dank. , 15


;----------------------------------------------------------------------------------------------
; msgbox, 4, BaxterWorks Software Testing, BaxterWorks Skriptcheck 005a Zähler , 3
;----------------------------------------------------------------------------------------------

return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MacroBax Stats     [Version 003]                                                                           │
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

