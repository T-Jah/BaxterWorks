CodeVersion := "1.0.0.8", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\uhr3.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, T-Jah Tom
;@Ahk2Exe-SetDescription Tools und Skripte
;@Ahk2Exe-SetFileVersion 1.0.0.8
;@Ahk2Exe-SetProductVersion 1.0.0.8
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks Tom
;@Ahk2Exe-SetProductName Tom
;------------------------------------------------------------------------------------->
; AHK AutoHotKey Skript. Handbuch und HP: https://ahkde.github.io/
; (c) 2021 T-Jah Tom
; https://www.tombesch.de					   04/2021 Version 001
;------------------------------------------------------------------------------------->
; Skript besteht überwiegend aus Schnippseln aus dem Handbuch und der Community.
;
; BaxterWorks Software:	http://www.baxterworks.de/software
;			http://blog.baxterworks.de
;------------------------------------------------------------------------------------->
;Titel: Uhr Digital simple. 
; HINWEIS: Position wird in ini geschrieben, aber nicht gelesen. quasi obsolet

; Script options
#SingleInstance force 			; oder off
#NoEnv
SetWorkingDir %A_ScriptDir%		; wichtig
SendMode Input
#Include %A_ScriptDir%

;Icon
Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\uhr3.ico

#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk


Vorarbeiten:
Gosub,currentTime
Gosub,guiupdator
SetTimer,currentTime,500



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
	AppName = UhrDigiSimple
	Bax_help = help	
	Skriptvorlage = MacroBax_008
	Bax_Icon = %Bax_Start%\Grafix\klee.ico
	LastLogIn = %A_Now%_%AppName%
	LastLogInZeit = %A_Now%
	LetzteAnmeldung = %A_UserName%
	LetzterEinsatz = %A_ComputerName%
	BaxNutzerName = %A_UserName%_%A_ComputerName%
	Bax_Start = %Bax_Start%
	;scriptini = %Bax_Start%\Config\%AppName%.ini



GoSub,TRAYMENU

;GUI
Gui, +AlwaysOnTop +Disabled -Caption +Owner
Gui Font, s26, Arial Black, Verdana, Segoe UI, bold
Gui Color, Red
;Gui, Add, Picture, x258 y4 w38 h33 gclose +BackgroundTrans,  %A_ScriptDir%\..\..\Grafix\close.png
Gui, Add, Picture, x0 y0 w300 h35 gUImove,  %A_ScriptDir%\..\..\Grafix\bar.png
Gui, Add, Text, x30 y34 w250 vbaxtime, %Time%
Gui, show, w300 h90, UhrDigiSimple


;WinSet
WinSet, Topmost, on, UhrDigiSimple
WinSet, Region, 5-5 W300 H90 R 40-40, UhrDigiSimple


WinWait, UhrDigiSimple
WinMove, 900, 30 ; Verwendet das von WinWait gefundene Fenster.
return



UImove:
PostMessage, 0xA1, 2,,, A
return

;---------------------------------------------------------------->
; AppStart (AutoExec Bereich geht nach dem letzten Eintrag weiter
; Also hier nach Traymenü.
;---------------------------------------------------------------->




Variablen:
ListVars
return

Version:
Run,%A_ScriptDir%\..\..\Log\Versionsinfo_%AppName%.txt
return

HotKeys:
ListHotkeys
return

Reload:
reload
return

TRAYMENU:
Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray,Add,%AppName%,About
Menu,Tray,Add
;Menu,Tray,Add,&Variablen...,Variablen
Menu,Tray,Add,&Neuerungen...,Version
;Menu,Tray,Add,&HotKeys...,HotKeys
Menu,Tray,Add,&Reload...,Reload
Menu,Tray,Add,&About...,About
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Tip,%AppName% %CodeVersion%
Menu,Tray,Default,%AppName%
return

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
Gui,99:Add,Text, R3 ,Die Uhr war mein erstes Projekt.`nEin prima Übungsskript und der Beginn`neiner wunderbaren Beziehung ;)
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

currentTime:
FormatTime,Time,T12,hh:mm:ss
Gosub,guiupdator
Return

guiupdator:
GuiControl, text, baxtime , %Time%
return


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

99GuiClose:
  Gui,99:Destroy
  OnMessage(0x200,"")
  DllCall("DestroyCursor","Uint",hCur)
Return

WM_MOUSEMOVE(wParam,lParam)
{
  Global hCurs
  MouseGetPos,,,,ctrl
  If ctrl in Static9,Static13,Static17
    DllCall("SetCursor","UInt",hCurs)
  Return
}
Return



Suspend:
  Suspend
Return

GuiClose:
DateiBeenden:     		; Benutzer hat "Exit" im Dateimenü ausgewählt.
ButtonCancel:			; falls es einen Button gibt
;GuiEscape:
CleanUp:
EXIT:
SavePosition:
DetectHiddenWindows On
;WinGetPos, X, Y, Width, Height, UhrDigiSimple
;If (x > 0)
;	IniWrite, % " x" X " y" Y " w" Width-16 " h" Height-39, %scriptini%, Position, WinPos
	IniWrite, %Lastseen% , %backuptxt%, Stats_%BaxNutzerName% , Lastseen
	IniWrite, %A_Now%_%AppName% , %backuptxt%, Stats_%BaxNutzerName% , LastLogIn
	IniWrite, %AppName%_%CodeVersion%_%Skriptvorlage%_%A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzung_%AppName%
	FileAppend, Nutzung: %A_Now% %A_Tab% Nutzer: %BaxNutzerName%  %A_Tab% App: %AppName%`n , %Bax_Start%\Config\%A_ComputerName%.bax
%A_ComputerName%.bax

; SoundPlay, NoFile.wav
  CTLCOLORS.Free()		; wenn classCTLColours benutzt wurde
SoundBeep, 750, 500

ExitApp
return
