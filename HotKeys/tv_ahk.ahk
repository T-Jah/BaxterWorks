;------------------------------------------------------------------------------------->
; AHK AutoHotKey Skript. Handbuch und HP: https://ahkde.github.io/
; (c) 2021 T-Jah Tom
; https://github.com/T-Jah					   05/2021 Version 008
;------------------------------------------------------------------------------------->
; Skript besteht überwiegend aus Schnippseln aus dem Handbuch und der Community.
;
; BaxterWorks Software:	http://www.baxterworks.de/software
;			http://blog.baxterworks.de
;                       ^ STRG + Shift ! Alt # WIN
;------------------------------------------------------------------------------------->
; More:    ......https://github.com/T-Jah
; Titel:   ......Name
; Licence: ......BaxterWorks Software is licensed under the MIT Licence

; Script options
#SingleInstance force 			; oder off
#NoEnv
SetWorkingDir %A_ScriptDir%		; wichtig
SendMode Input


; AHK Vorlagen


:*:ahk_titel::
SendInput {Raw}
(
;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Titel und Info         [Version 001]                                                                     │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

)
return

:*:ahk_break::
SendInput {Raw}
(
;---------------------------------------------------------------->
; ANFANG / ENDE
;---------------------------------------------------------------->

)
return


:*:ahk_box4::
SendInput {Raw}
(
/**
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│                                                             │
│                                                             │
│                                                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
**/

)
return

:*:ahk_box3::
SendInput {Raw}
(
; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Direktiven für den Compiler                                                                              │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

)
return

:*:ahk_box2::
SendInput {Raw}
(

;┌────────────────────────────────────┐
;│ Box2:                              │
;│   - jetzt noch schöner             │
;│   - und ohne Ritzen                │
;│   - Semikolon nur im Skript nötig  │
;│                                    │
;│                                    │
;│                                    │
;│                                    │
;│                                    │
;│                                    │
;│                                    │
;│                                    │
;└────────────────────────────────────┘

)
return

:*:ahk_box1::
SendInput {Raw}
(

;┌────────────────────────────────────┐
;│                                    │
;│            BaxterWorks             │
;│       =====================        │
;│            AHK Skripte             │
;│ Box1:                              │
;│   - jetzt noch schöner             │
;│   - und ohne Ritzen                │
;│   - Semikolon nur im Skript nötig  │
;│                                    │
;│                                    │
;│                                    │
;│       by T-Jah Tom                 │
;│       https://github.com/T-Jah     │
;│                                    │
;│                                    │
;│                                    │
;└────────────────────────────────────┘

)
return




:*:ahk_head::
SendInput {Raw}
(
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
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 011               MiniBax AHK Skript

/*
 * MiniBax
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
	Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\cool2.ico	; #NoTrayIcon
; OnExit
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Variablen, zB Pfade     [Version 006]                                                                    │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; Startumgebungsvariablen laden
	IniRead, Bax_Start , %A_ScriptDir%\..\..\Config\BaxterWorks.ini, FixVars, Bax_Start
	IniRead, homeini , %Bax_Start%\Config\BaxterWorks.ini, FixVars, homeini
	IniRead, userini , %homeini%, FixVars, userini
	IniRead, Bax_Bar , %homeini%, FixVars, Bax_Bar
	IniRead, backuptxt , %homeini%, FixVars, backuptxt
	IniRead, Bax_exe , %homeini%, FixVars, Bax_exe

; Startumgebungsvariablen festlegen
	AppName = MiniBax
	Bax_help = help	
	LetzteAnmeldung = %A_UserName%
	LetzterEinsatz = %A_ComputerName%
	BaxNutzerName = %A_UserName%_%A_ComputerName%
	Bax_Start = %Bax_Start%
	scriptini = %Bax_Start%\Config\%AppName%.ini
	Bax_Icon = %Bax_Start%\Grafix\cool2.ico
	
	
; Variablentest
; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox,  %homeini% 
)

return
;------------------------------------------------------------------------------------->
;------------------------------------------------------------------------------------->



:*:ahk_info::
SendInput {Raw}
(
/**
 * AHK AutoHotKey Skript. Handbuch und HP: https://ahkde.github.io/
 *           *  http://www.baxterworks.de/software  *	   
 * ----------------------------------------------------------------
 * 
 *
 *
*/

)
return
;------------------------------------------------------------------------------------->
;------------------------------------------------------------------------------------->



:*:ahk_options::
SendInput {Raw}
(
/*
 * MiniBax
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
	Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\cool2.ico	; #NoTrayIcon
; OnExit
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk

)

return

;------------------------------------------------------------------------------------->
;------------------------------------------------------------------------------------->


:*:ahk_icon::
SendInput {Raw}
(
Menu Tray, Icon, %A_ScriptDir%\..\Grafix\bax.ico 	; #NoTrayIcon

)

return



:*:ahk_ende::
SendInput {Raw}
(
; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   EndSub         [Version 003]           + ohne GUI                                                        │
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
	;IniWrite, %Lastseen%_%BaxNutzerName% , %backuptxt%, %BaxNutzerName% , Lastseen
ButtonCancel:			; falls es einen Button gibt
GuiEscape:
CleanUp:
SavePosition:
	DetectHiddenWindows On
	; SoundPlay, NoFile.wav
   	Gui, Destroy			; gibt die Ressource frei
	SoundBeep, 750, 500
  	CTLCOLORS.Free()		; wenn classCTLColours benutzt wurde
	Gdip_Shutdown(pToken)		; wird in includes gestartet

	if FileExist("..\..\Files\*.htm")
	FileDelete %Bax_Start%\Files\*.htm

ExitApp
)

return
;------------------------------------------------------------------------------------->
;------------------------------------------------------------------------------------->


:*:ahk_tabelle1::
SendInput {Raw}
(

; 
; ┌──────────────────────────────────────────────────────┐  
; │							 │  
; ├─────┬───────────────────────┬────────────────────────┤  
; │     │                       │                        │  
; ├─────┼───────────────────────┼────────────────────────┤  
; │     │                       │                        │  
; └─────┴───────────────────────┴────────────────────────┘  
; 
)
return



;------------------------------------------------------------------------------------->
;------------------------------------------------------------------------------------->

:*:ahk_tabelle2::
SendInput {Raw}
(
;
; ┌──────────────────────────────────────────────────────┐  
; │                                                      │  
; ├───────────────────┬────────────────┬─────────────────┤  
; │                   │                │                 │  
; ├───────────────────┼────────────────┼─────────────────┤  
; │                   │ 	       │		 │  
; └───────────────────┴────────────────┴─────────────────┘  
; 
)
return


;------------------------------------------------------------------------------------->

:*:ahk_msg1::
SendInput {Raw}
(
MsgBox, 4,BaxterWorks Software meldet , Du bist dran - triff eine Entscheidung, 5 
	IfMsgBox, No
    	Return  			; Benutzer sagt nö
	IfMsgBox, Timeout
    	Return 				; auch nein, timeout.
					; wenn nicht nein und nicht timeout (also ja) fortsetzen
	MsgBox, 0,BaxterWorks Software informiert, Juhuu eine Entscheidung. (5 Sekunden Timer), 5
	Exit

; Version 003 by T-Jah Tom, BaxterWorks - http://www.baxterworks.de/software

)
return


;--------------------------------------------------;
;--------------------------------------------------;

 
:*:ahk_tjah::
SendInput {Raw}
(
/*

████████╗        ██╗ █████╗ ██╗  ██╗    ████████╗ ██████╗ ███╗   ███╗
╚══██╔══╝        ██║██╔══██╗██║  ██║    ╚══██╔══╝██╔═══██╗████╗ ████║
   ██║█████╗     ██║███████║███████║       ██║   ██║   ██║██╔████╔██║
   ██║╚════╝██   ██║██╔══██║██╔══██║       ██║   ██║   ██║██║╚██╔╝██║
   ██║      ╚█████╔╝██║  ██║██║  ██║       ██║   ╚██████╔╝██║ ╚═╝ ██║
   ╚═╝       ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝       ╚═╝    ╚═════╝ ╚═╝     ╚═╝
                                                                     
*/
)
return

