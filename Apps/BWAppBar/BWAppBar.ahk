CodeVersion := "1.0.2.4", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\appbar.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription BWAppBar - Taskleiste2 credits to SKAN
;@Ahk2Exe-SetFileVersion 1.0.2.4
;@Ahk2Exe-SetProductVersion 1.0.2.4
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks BWAppBar
;@Ahk2Exe-SetProductName BWAppBar
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
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 017              M.i.n.i.Bax AHK Skript
;
;                                 keine Standardreihenfolge in diesem Skript
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
	AppName = BWAppBar
	Bax_help = help_bwappbar	
	Skriptvorlage = MiniBax_017
	Bax_Icon = %Bax_Start%\Grafix\appbar.ico
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




if !FileExist("%Bax_Bar%\00AppBar.lnk")
FileCreateShortcut, %A_ScriptDir%\00AppBar.exe, %Bax_Bar%\00AppBar.lnk, %A_ScriptDir%, "%A_ScriptFullPath%", Menü mit Rechtsklick oder WIN+Z, %A_ScriptDir%\..\..\Grafix\menuico.ico,      

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  Sub Ini  [Version 007]        + nur write                                                         │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

	IniWrite, %LetzteAnmeldung% , %scriptini%, Nutzerinfo, Letzter Nutzer
	IniWrite, %LetzterEinsatz% , %scriptini%, Nutzerinfo, Letzter Rechner
	IniWrite, %Bax_IP% , %scriptini%, Nutzerinfo, Bax_IP
	IniWrite, %FensterVersion% , %scriptini%, Nutzerinfo, FensterVersion
	IniWrite, %Skriptvorlage% , %scriptini%, Nutzerinfo, Skriptvorlage
	IniWrite, %A_Now%_%AppName% , %scriptini%, Stats_%BaxNutzerName% , LastLogIn
	IniWrite, %A_Now% , %scriptini%, Stats_%BaxNutzerName% , LastLogInZeit



/*
 * BWAppBar
 * Copyright 2021 T-Jah Tom
 * All Rights Reserved.
 * Use, reproduction, distribution, and modification of this code is subject to the terms and
 * conditions of the MIT license, available at http://www.opensource.org/licenses/mit-license.php
 *
 * Author: T-Jah Tom (Basisversion der AppBar ist von SKAN 2007)
 * Project: https://github.com/T-Jah
 *
 * ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * │   Skriptoptionen 	                       [Version 0xx]      +                                             │
 * └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 *
 *                         BaxterWorks Software:	http://www.baxterworks.de/software
 *			                 http://blog.baxterworks.de
 *                                       ^ STRG + Shift ! Alt # WIN
 * 
 */
#SingleInstance force 		; oder off, force, ignore
SetBatchLines -1
CoordMode, Mouse  , Screen
CoordMode, Tooltip, Screen

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BWAppBar AppChecker      [Version 001]                                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;



 If !FindProc("BaxterWorks.exe")
      Run, %Bax_Start%\BaxterWorks.exe
; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax Stats     [Version 004]          +include  +return                                                │
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

	FileAppend, %A_Now% | %CodeVersion% | %Fensterversion% | %Skriptvorlage% | %AppName% | Starts: %Appnutzcount% | Pause: %Zwischenzeit% Stunden | Nutzung: %Nutzungstage% Tage`n , %Bax_Start%\Files\Log\%AppName%_log.txt


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BWAppBar Rechtsklickmenü         [Version 006]                                                           │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Erstellt ein aufklappbares Menü durch Hinzufügen von Menüpunkten.
Menu, 00AppBar, Add, Icons managen, IconHandler
Menu, 00AppBar, Icon, Icons managen, C:\WINDOWS\System32\SHELL32.dll,97
Menu, 00AppBar, Add, Ordner anzeigen, OrdnerHandler
Menu, 00AppBar, Icon, Ordner anzeigen, C:\WINDOWS\System32\SHELL32.dll,4
Menu, 00AppBar, Add  ; Fügt eine Trennlinie ein.

; Erstellt ein weiteres Menü, das als Untermenü für das obige Menü dienen soll.
Menu, SubAppBar1, Add, Versionsinfo BWAppBar, AppBarHandler
Menu, SubAppBar1, Icon, Versionsinfo BWAppBar, C:\WINDOWS\System32\SHELL32.dll,21
Menu, SubAppBar1, Add, Versionsinfo 00AppBar-Fenster, ConfigHandler
Menu, SubAppBar1, Icon, Versionsinfo 00AppBar-Fenster, C:\WINDOWS\System32\SHELL32.dll,21

; Erstellt ein weiteres Menü, das als Untermenü für das obige Menü dienen soll.
Menu, SubAppBar2, Add, Hilfetexte Übersicht, HilfeHandler1
Menu, SubAppBar2, Icon, Hilfetexte Übersicht, C:\WINDOWS\System32\SHELL32.dll,24
Menu, SubAppBar2, Add, Hilfetexte BWAppBar, HilfeHandler2
Menu, SubAppBar2, Icon, Hilfetexte BWAppBar, C:\WINDOWS\System32\SHELL32.dll,24
Menu, SubAppBar2, Add, Hilfetexte HotKeys, HilfeHandler3
Menu, SubAppBar2, Icon, Hilfetexte HotKeys, C:\WINDOWS\System32\SHELL32.dll,24

; Erstellt ein weiteres Menü, das als Untermenü für das obige Menü dienen soll.
Menu, SubAppBar3, Add, GitHub, AppsHandler1
Menu, SubAppBar3, Icon, GitHub, %Bax_Start%\Grafix\github1.ico, 1

; Erstellt ein weiteres Menü, das als Untermenü für das obige Menü dienen soll.
Menu, SubAppBar4, Add, T-Jah Tom @BaxterWorks, TGHandler1
Menu, SubAppBar4, Icon, T-Jah Tom @BaxterWorks, %Bax_Start%\Grafix\logo_tjah2.ico, 1
Menu, SubAppBar4, Add, BaxterWorks Stickerpacks, TGHandler2
Menu, SubAppBar4, Icon, BaxterWorks Stickerpacks, %Bax_Start%\Grafix\favicon.ico, 1
Menu, SubAppBar4, Add
Menu, SubAppBar4, Add, BaxterWorks_Bot, TGHandler3
Menu, SubAppBar4, Icon, BaxterWorks_Bot, %Bax_Start%\Grafix\autotext.ico, 1
Menu, SubAppBar4, Add, Tom's Knecht, TGHandler4
Menu, SubAppBar4, Icon, Tom's Knecht, %Bax_Start%\Grafix\logo_tjah.ico, 1
Menu, SubAppBar4, Add, GTA Werkstattmeister, TGHandler5
Menu, SubAppBar4, Icon, GTA Werkstattmeister, %Bax_Start%\Grafix\gta_moped2.ico, 1
Menu, SubAppBar4, Add, Helferlein, TGHandler6
Menu, SubAppBar4, Icon, Helferlein, %Bax_Start%\Grafix\linux.ico, 1
Menu, SubAppBar4, Add
Menu, SubAppBar4, Add, Hanfkanal, TGHandler7
Menu, SubAppBar4, Icon, Hanfkanal, %Bax_Start%\Grafix\runaway.ico, 1
Menu, SubAppBar4, Add, VfL Bochum Gruppe, TGHandler8
Menu, SubAppBar4, Icon, VfL Bochum Gruppe, %Bax_Start%\Grafix\vfl.ico, 1
Menu, SubAppBar4, Add, Reggae Kanal, TGHandler9
Menu, SubAppBar4, Icon, Reggae Kanal, %Bax_Start%\Grafix\soundcheck.ico, 1
Menu, SubAppBar4, Add, FMS Gruppe, TGHandler10
Menu, SubAppBar4, Icon, FMS Gruppe, %Bax_Start%\Grafix\pin.ico, 1


; Erstellt ein Untermenü im ersten Menü (mit einem nach rechts gerichteten Pfeil). Sobald der Benutzer dieses Untermenü auswählt, wird das zweite Menü angezeigt.
Menu, 00AppBar, Add, Versionsinfos, :SubAppBar1
Menu, 00AppBar, Icon, Versionsinfos, C:\WINDOWS\System32\SHELL32.dll,21
Menu, 00AppBar, Add, Hilfetexte, :SubAppBar2
Menu, 00AppBar, Icon, Hilfetexte, C:\WINDOWS\System32\SHELL32.dll,24
Menu, 00AppBar, Add, BaxterWorks Software, :SubAppBar3
Menu, 00AppBar, Icon, BaxterWorks Software, %Bax_Start%\Grafix\bax.ico, 1
Menu, 00AppBar, Add, Telegram Messenger, :SubAppBar4
Menu, 00AppBar, Icon, Telegram Messenger, %Bax_Start%\Grafix\telegram.ico, 1

Menu, 00AppBar, Add  ; Fügt eine Trennlinie unterhalb des Untermenüs ein.
Menu, 00AppBar, Add, About, AboutHandler  ; Fügt einen weiteren Menüpunkt unterhalb des Untermenüs ein.
Menu, 00AppBar, Icon, About, C:\WINDOWS\System32\SHELL32.dll,222
;return  ; Ende des automatischen Ausführungsbereichs.




Menu, Tray, NoStandard
Menu, Tray, Add, AppBar Hide/Show, ToggleGUI
Menu, Tray, Add
Menu, Tray, Default, AppBar Hide/Show
Menu,Tray,Add						; Trennlinie
Menu,Tray,Add,&HotKeys...,HotKeys
Menu,Tray,Add,&Reload...,Reload
Menu,Tray,Add,&Credits...,credits
Menu,Tray,Add,&Hilfe...,HilfeTray
Menu,Tray,Add						; Trennlinie
Menu,Tray,Add,E&xit,EXIT
Menu, Tray, Click, 1
Menu, Tray, Tip, BaxterWorks AppBar %codeversion%

Menu, RClick, Add, BWAppBar Einstellungen, RMenu
QLF := A_AppData . "\Microsoft\Internet Explorer\Quick Launch"
Sz := 32 , Sp := 9 ; Icon Size and Spacing
Gui, Margin, 2,2
Gui -Caption +ToolWindow +AlwaysOnTop +Border +LastFound +hwndhAB

Loop %QLF%\*.lnk {
 LINK := A_LoopFileLongPath 
 SplitPath, LINK,,,, FN 
 FileGetShortcut, %LINK%, Tar, Dir, Args, Desc, Ico, IcoN, Run 
 Target := ( Ico!="" ) ? ICO : TAR
 SplitPath, Target,,, Ext
 If Ext not in DLL,EXE,ICO,ICL
    {
      ; http://www.autohotkey.com/forum/viewtopic.php?p=57646#57646
      RegRead, From   , HKEY_CLASSES_ROOT, .%Ext%              ; Thanks KIU
      RegRead, default, HKEY_CLASSES_ROOT, %From%\DefaultIcon  ; 
      StringSplit, IC, default, `,
      IcoN := Ic2, Target := Ic1
    }
 Gui, Add, Picture, X+%Sp% y2 w%Sz% h%Sz% Icon%IcoN% vI%A_Index% gRun, % Target
 AppData .= FN "|" LINK "`n"
}
SysGet, VirtuelleBreite, 78
SysGet, VirtuelleHöhe, 79
Gui, Show, x0 y0 w%VirtuelleBreite%
WinGetPos, GX,GY,GW,GH, ahk_id %hAB%

ABM := DllCall( "RegisterWindowMessage", Str,"AppBarMsg", "UInt" )
OnMessage( ABM, "ABM_Callback" )
OnMessage( (WM_MOUSEMOVE := 0x200) , "CheckMousePos" )

; APPBARDATA : http://msdn2.microsoft.com/en-us/library/ms538008.aspx
VarSetCapacity( APPBARDATA , (cbAPPBARDATA := A_PtrSize == 8 ? 48 : 36), 0 )
Off :=  NumPut(  cbAPPBARDATA, APPBARDATA, "Ptr" )
Off :=  NumPut( hAB, Off+0, "Ptr" )
Off :=  NumPut( ABM, Off+0, "UInt" )
Off :=  NumPut(   1, Off+0, "UInt" ) 
Off :=  NumPut(  GX, Off+0, "Int" ) 
Off :=  NumPut(  GY, Off+0, "Int" ) 
Off :=  NumPut(  GW, Off+0, "Int" ) 
Off :=  NumPut(  GH, Off+0, "Int" )
;MsgBox % Off - &APPBARDATA
Off :=  NumPut(   1, Off+0, "Ptr" )
GoSub, RegisterAppBar

;OnExit, QuitScript
Return

ToggleGUI:
 If DllCall("IsWindowVisible", Ptr,hAB) {
    Gui, Hide
    GoSub, RemoveAppBar
 } Else {
    Gui, Show, NoActivate
    GoSub, RegisterAppBar
 }
Return

RegisterAppBar:
  DllCall("Shell32.dll\SHAppBarMessage", UInt,(ABM_NEW:=0x0)     , Ptr,&APPBARDATA )
  DllCall("Shell32.dll\SHAppBarMessage", UInt,(ABM_QUERYPOS:=0x2), Ptr,&APPBARDATA )
  DllCall("Shell32.dll\SHAppBarMessage", UInt,(ABM_SETPOS:=0x3)  , Ptr,&APPBARDATA )
Return

RemoveAppBar:
  DllCall("Shell32.dll\SHAppBarMessage", UInt,(ABM_REMOVE := 0x1), Ptr,&APPBARDATA )
Return

Run:
  Index := SubStr(A_GuiControl,2,3)
  RowData := AGetF( AppData, Index, "`n" ) , LinkFile := AGetF( RowData, 2 )
  Run, %LinkFile%
Return

GuiContextMenu:
  Index := SubStr(A_GuiControl,2,3) 
  ToolTip
  Menu, RClick, Show
Return

ShowProperties:
  RowData  := AGetF( AppData, Index, "`n" )
  LinkFile := AGetF( RowData, 2 )
  Run, Properties %LinkFile%
Return

CheckMousePos()  { ; Triggered with WM_MOUSEMOVE
Global Mouse
If ( !Mouse ) {
                Mouse := True
                SetTimer, ShowToolTip, 400
                SetTimer, ToolTipOff , 400
}             }

ShowToolTip:
   MouseGetPos,,,,ClassNN,1
   ControlGetPos, X, Y, W, H, %ClassNN%, ahk_id %hAB%
   Index := SubStr(ClassNN,7,3) , RowData := AGetF( AppData, Index, "`n" ) 
   FileGetShortcut, % AGetF( RowData, 2 ),,,, Desc
   Tooltip % AGetF( RowData, 1 ) . ((Desc!="") ? "`n" Desc : "" ), % X, % H+Y+3
Return

ToolTipOff:
   MouseGetPos,,, hWnd,Ctrl,3
   If ( hWnd != hAB ) {
      Tooltip
      Mouse := False
      SetTimer, ToolTipOff , OFF
      SetTimer, ShowToolTip, OFF
} Return

;---------------------------------------------------------------------Dropper

; Dropfiles GUI by T-Jah Tom

GuiDropFiles(GuiHwnd, DateiArray, ElementHwnd, X, Y) {
	for i, Datei in DateiArray
		MsgBox Datei %i% ist:`n%Datei%`n`nKeine Ahnung, was ich jetzt damit machen soll.`n`nVerknüpfungen per DragnDrop anzulegen ist für eine spätere Version geplant
}

;---------------------------------------------------------------------Dropper





AGetF(Str="",Fld=1, D="" )  {  ;                                           ArrayGetField() 
  Loop,Parse,Str, % ( D="" ? "|" : D ) 
    IfEqual,A_Index,%Fld%, Return,A_LoopField 
                            } 

ABM_Callback( wParam, LParam, Msg, HWnd ) {
; Not much messages received. When Taskbar settings are
; changed the wParam becomes 1, else it is always 2
}
Exit:
QuitScript:
  GoSub, RemoveAppbar
if FileExist("..\..\Files\*.htm")
FileDelete %A_ScriptDir%\..\..\Files\*.htm
	FormatTime, LastSeen,, LongDate
	IniWrite, %Lastseen% , %backuptxt%, Stats_%BaxNutzerName% , Lastseen
	IniWrite, %A_Now%_%AppName% , %backuptxt%, Stats_%BaxNutzerName% , LastLogIn
	IniWrite, %AppName%_%CodeVersion%_%Skriptvorlage%_%A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzung_%AppName%
	IniWrite, %A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzzeit_%AppName%
FileAppend, Nutzung: %A_Now% %A_Tab% Nutzer: %BaxNutzerName% %A_Tab% App: %AppName%_%CodeVersion% %A_Tab% Skriptvorlage: %Skriptvorlage% %A_Tab% %Appnutzcount% Starts in %Nutzungstage% Tagen`n , %Bax_Start%\Files\Stats\%A_ComputerName%.txt

  ExitApp
Return


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Subs Traymenü    [Version 004]     +                                                                     │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

HilfeTray:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/%Bax_help%.htm, %A_ScriptDir%\..\..\Files\%Bax_help%.htm
	}
	run,%A_ScriptDir%\..\..\Files\%Bax_help%.htm
	return

credits:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/credits.htm, %A_ScriptDir%\..\..\Files\credits.htm
	}
	run,%A_ScriptDir%\..\..\Files\credits.htm
	return

HotKeys:
	ListHotkeys
	return

Reload:
	reload
	return



;---------------Rechtsklickmenü--------------------------------------------------------------
IconHandler:
	;MsgBox Sie haben %A_ThisMenuItem% im Menü %A_ThisMenu% ausgewählt.
	run,%A_ScriptDir%\00AppBar.exe
	return

OrdnerHandler:
	;MsgBox Sie haben %A_ThisMenuItem% im Menü %A_ThisMenu% ausgewählt.
	run,%Bax_Bar%
	return

HilfeHandler1:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help.htm, %A_ScriptDir%\..\..\Files\help.htm
	}
	run,%A_ScriptDir%\..\..\Files\help.htm
	return

HilfeHandler2:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_bwappbar.htm, %A_ScriptDir%\..\..\Files\help_bwappbar.htm
	}
	run,%A_ScriptDir%\..\..\Files\help_bwappbar.htm
	return

HilfeHandler3:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_hotkeys.htm, %A_ScriptDir%\..\..\Files\help_hotkeys.htm
	}
	run,%A_ScriptDir%\..\..\Files\help_hotkeys.htm
	return

AppBarHandler:
	Run, %A_ScriptDir%\..\..\Log\Versionsinfo_%AppName%.txt
	return

ConfigHandler:
	Run, %A_ScriptDir%\..\..\Log\Versionsinfo_00AppBar.txt
	return

AppsHandler1:
	run, https://github.com/T-Jah
	return

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

AboutHandler:
	MsgBox, %AppName% %CodeVersion%`nBaxterWorks Software`n(c) 1999-2021 T-Jah Tom`n`nMehr Infos auf der Webseite.
	return


#z::Menu, 00AppBar, Show  ; Drücken Sie WIN+Z, um das Menü anzuzeigen.


RMenu:
	Menu, 00AppBar, Show
return

;--------------------------------ENDE Rechtsklickmenü

; Sub Appchecker

FindProc(p) {
   Process, Exist, % p
   Return, ErrorLevel
}
