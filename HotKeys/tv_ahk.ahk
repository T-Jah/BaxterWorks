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


; AHK HotStrings

:*:A_S::%A_ScriptDir%
:*:A_W::%A_WorkingDir%
:*:A_P::%A_ProgramData%
:*:A_U::%A_UserName%
:*:A_C::%A_ComputerName%



; AHK Vorlagen


:*:ahk_break::
SendInput {Raw}
(
;---------------------------------------------------------------->
; ANFANG / ENDE
;---------------------------------------------------------------->

)
return



:*:ahk_1head::
SendInput {Raw}
(
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
/**
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
**/
)
return




:*:ahk_head::
SendInput {Raw}
(

/*
 * Muster
 * Copyright 2021 T-Jah Tom
 * All Rights Reserved.
 * Use, reproduction, distribution, and modification of this code is subject to the terms and
 * conditions of the MIT license, available at http://www.opensource.org/licenses/mit-license.php
 *
 * Author: T-Jah Tom
 * Project: https://github.com/T-Jah
 *
 * ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * │   Skriptoptionen 	                       [Version 009]                                                    │
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
SetWorkingDir %A_ScriptDir%		; wichtig
SendMode Input

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


:*:ahk_kasten1::
SendInput {Raw}
(
noch nicht fertig

)
return



:*:ahk_options::
SendInput {Raw}
(
;                       ^ STRG + Shift ! Alt # WIN
;-------------------------------------------------------------------------------------------------------------
#SingleInstance force 		; oder off, force, ignore
#NoEnv				
#Persistent			; mit ExitApp statt mit Exit beenden
#MaxMem 512			
; #NoTrayIcon			; auf doppelten Eintrag achten
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

; Icon
Menu Tray, Icon, %A_ScriptDir%\..\Grafix\bax.ico	; #NoTrayIcon

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


:*:ahk_1ende::
SendInput {Raw}
(
#Persistent  ; Verhindert, dass sich das Skript automatisch beendet.

;---------------------------------------------------------------->
; BaxEx Klasse
;---------------------------------------------------------------->

#Include %A_ScriptDir%\..\Lib\BaxFunk_Exit.ahk

; ----------- oben ----------------->


; ----------- unten ---------------->
EXIT:
GuiClose:
DateiBeenden:     		; Benutzer hat "Exit" im Dateimenü ausgewählt.
ButtonCancel:			; falls es einen Button gibt
GuiEscape:
CleanUp:
; SoundPlay, NoFile.wav
   Gui, Destroy			; gibt die Ressource frei
   CTLCOLORS.Free()		; wenn classCTLColours benutzt wurde
SoundBeep, 750, 500
ExitApp
)

return

:*:ahk_ende::
SendInput {Raw}
(
;---------------------------------------------------------------->
; BaxEx Klasse
;---------------------------------------------------------------->

#Persistent  ; Verhindert, dass sich das Skript automatisch beendet.
OnExit(ObjBindMethod(BaxEx, "Beenden"))
class BaxEx
{
    Beenden()
    {
        SplashTextOn, 400 fs18,,;   BaxEx macht noch eben ein wenig sauber.
Sleep, 3000
SplashTextOff
	return
        /*
        und tüss
        */
    }
}
; ----------- oben ----------------->


; ----------- unten ---------------->
EXIT:
GuiClose:
DateiBeenden:     		; Benutzer hat "Exit" im Dateimenü ausgewählt.
ButtonCancel:			; falls es einen Button gibt
GuiEscape:
CleanUp:
; SoundPlay, NoFile.wav
   Gui, Destroy			; gibt die Ressource frei
   CTLCOLORS.Free()		; wenn classCTLColours benutzt wurde
SoundBeep, 750, 500
ExitApp
)

return
;------------------------------------------------------------------------------------->
;------------------------------------------------------------------------------------->



:*:ahk_index::
SendInput {Raw}
(
/**
 *
 * AHK AutoHotKey Skript. Handbuch und HP: https://ahkde.github.io/
 *          * http://www.baxterworks.de/software *
 * ---------------------------------------------------------------->
 * Schnippselname: 
 * Skript aktiviert über:
 *      - include in appstart.ahk
 * Skript in Gebrauch für:
 *      - unbekannt
 * andere Skripte in Relation:
 *      - urlutils.ahk
 *
*/

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
