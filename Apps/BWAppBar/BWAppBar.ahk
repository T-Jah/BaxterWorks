CodeVersion := "1.0.1.3", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\appbar.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription BWAppBar - Taskleiste2 Credits to SKAN
;@Ahk2Exe-SetFileVersion 1.0.1.3
;@Ahk2Exe-SetProductVersion 1.0.1.3
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks BWAppBar
;@Ahk2Exe-SetProductName BWAppBar
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │            __________                  __                __      __             __                         │
; │            \______   \_____  ___  ____/  |_  ___________/  \    /  \___________|  | __  ______             │
; │             |    |  _/\__  \ \  \/  /\   __\/ __ \_  __ \   \/\/   /  _ \_  __ \  |/ / /  ___/             │
; │             |    |   \ / __ \_>    <  |  | \  ___/|  | \/\        (  <_> )  | \/    <  \___ \              │
; │             |______  /(____  /__/\_ \ |__|  \___  >__|    \__/\  / \____/|__|  |__|_ \/____  >             │
; │                    \/      \/      \/           \/             \/                   \/     \/              │
; │              http://www.baxterworks.de/software                      (c) 1999-2021 T-Jah Tom               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;   Direktiven nach ganz oben                                                               BWAppBar AHK Skript

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Vorarbeiten: Pfade festlegen, Apps checken [Version 002]                                                 │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

	IniRead, homeini , %A_ScriptDir%\..\..\Config\BaxterWorks.ini, FixVars, homeini
	IniRead, Bax_Start , %homeini%, FixVars, Bax_Start
	IniRead, userini , %homeini%, FixVars, userini
	IniRead, Bax_Bar , %homeini%, FixVars, Bax_Bar
	IniRead, Bax_IP , %homeini%, Netzinfo, Letzte IP
	IniRead, PCName , %homeini%, Netzinfo, PCName
	IniRead, FensterVersion , %homeini%, Netzinfo, FensterVersion

	IniRead, Ziel1, %userini%, Dropper, Ziel1, %A_Space% 
	IniRead, Ziel2, %userini%, Dropper, Ziel2, %A_Space% 
	IniRead, DeinOrdner1, %userini%, 2Win, DeinOrdner1, %A_Space% 
	IniRead, DeinOrdner2, %userini%, 2Win, DeinOrdner2, %A_Space% 
	IniRead, Bax_JobDir, %userini%, 2Win, Bax_JobDir, %A_Space% 
	IniRead, Bax_Flex, %userini%, 2Win, Bax_Flex, %A_Space% 

; Startumgebungsvariablen festlegen
	AppName = BWAppBar
	Bax_Icon = %Bax_Start%\Grafix\appbar.ico
	scriptini = %Bax_Start%\Config\%AppName%.ini

; Startumgebungsvariablen erfassen
	LetzteAnmeldung = %A_UserName%
	LetzterEinsatz = %A_ComputerName%



if !FileExist("%Bax_Bar%\00AppBar.lnk")
FileCreateShortcut, %A_ScriptDir%\00AppBar.exe, %Bax_Bar%\00AppBar.lnk, %A_ScriptDir%, "%A_ScriptFullPath%", Menü mit Rechtsklick oder WIN+Z, %A_ScriptDir%\..\..\Grafix\menuico.ico,      

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
; │   BWAppBar Rechtsklickmenü         [Version 006]                                                           │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Erstellt ein aufklappbares Menü durch Hinzufügen von Menüpunkten.
Menu, 00AppBar, Add, Icons managen, IconHandler
Menu, 00AppBar, Add, Ordner anzeigen, OrdnerHandler
Menu, 00AppBar, Add  ; Fügt eine Trennlinie ein.

; Erstellt ein weiteres Menü, das als Untermenü für das obige Menü dienen soll.
Menu, SubAppBar1, Add, Versionsinfo BWAppBar, AppBarHandler
Menu, SubAppBar1, Add, Versionsinfo 00AppBar-Fenster, ConfigHandler

; Erstellt ein weiteres Menü, das als Untermenü für das obige Menü dienen soll.
Menu, SubAppBar2, Add, Hilfetexte Übersicht, HilfeHandler1
Menu, SubAppBar2, Add, Hilfetexte BWAppBar, HilfeHandler2
Menu, SubAppBar2, Add, Hilfetexte HotKeys, HilfeHandler3

; Erstellt ein weiteres Menü, das als Untermenü für das obige Menü dienen soll.
Menu, SubAppBar3, Add, BaxterWorks Software, AppsHandler1

; Erstellt ein weiteres Menü, das als Untermenü für das obige Menü dienen soll.
Menu, SubAppBar4, Add, T-Jah Tom @BaxterWorks, TGHandler1
Menu, SubAppBar4, Add, BaxterWorks Stickerpacks, TGHandler2
Menu, SubAppBar4, Add
Menu, SubAppBar4, Add, BaxterWorks_Bot, TGHandler3
Menu, SubAppBar4, Add, Tom's Knecht, TGHandler4
Menu, SubAppBar4, Add, GTA Werkstattmeister, TGHandler5
Menu, SubAppBar4, Add, Helferlein, TGHandler6
Menu, SubAppBar4, Add
Menu, SubAppBar4, Add, Hanfkanal, TGHandler7
Menu, SubAppBar4, Add, VfL Bochum Gruppe, TGHandler8
Menu, SubAppBar4, Add, Reggae Kanal, TGHandler9
Menu, SubAppBar4, Add, FMS Gruppe, TGHandler10


; Erstellt ein Untermenü im ersten Menü (mit einem nach rechts gerichteten Pfeil). Sobald der Benutzer dieses Untermenü auswählt, wird das zweite Menü angezeigt.
Menu, 00AppBar, Add, Versionsinfos, :SubAppBar1
Menu, 00AppBar, Add, Hilfetexte, :SubAppBar2
Menu, 00AppBar, Add, BaxterWorks Software, :SubAppBar3
Menu, 00AppBar, Add, Telegram Messenger, :SubAppBar4

Menu, 00AppBar, Add  ; Fügt eine Trennlinie unterhalb des Untermenüs ein.
Menu, 00AppBar, Add, About, AboutHandler  ; Fügt einen weiteren Menüpunkt unterhalb des Untermenüs ein.
;return  ; Ende des automatischen Ausführungsbereichs.




Menu, Tray, NoStandard
Menu, Tray, Add, AppBar Hide/Show, ToggleGUI
Menu, Tray, Add
Menu, Tray, Default, AppBar Hide/Show
Menu,Tray,Add						; Trennlinie
Menu,Tray,Add,&HotKeys...,HotKeys
Menu,Tray,Add,&Reload...,Reload
Menu,Tray,Add,&Credits...,Credits
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

OnExit, QuitScript
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
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help_bwappbar.htm, %A_ScriptDir%\..\..\Files\help_bwappbar.htm
	}
	run,%A_ScriptDir%\..\..\Files\help_bwappbar.htm
	return

Credits:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/Credits.htm, %A_ScriptDir%\..\..\Files\Credits.htm
	}
	run,%A_ScriptDir%\..\..\Files\Credits.htm
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