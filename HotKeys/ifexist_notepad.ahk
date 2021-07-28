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


; Beispiel: 
; #IfWinExist ahk_class Notepad && #IfWinActive ahk_class Notepad			
; #c::MsgBox Sie haben WIN+C gedrückt`, während der Texteditor aktiv ist.
; ::bzw::Dieser Ersatztext für "bzw" wird nur im Texteditor erscheinen.
; #If






#IfWinExist ahk_class Notepad && #IfWinActive ahk_class Notepad
^n::
DetectHiddenWindows, On
SetTitleMatchMode, 2
Run, notepad.exe
WinWaitActive, Unbenannt - Editor,, 2
if ErrorLevel
{
    MsgBox, WinWait hat das Zeitlimit überschritten.
    return
}
else
    WinMaximize ; Verwendet das von WinWaitActive gefundene Fenster.

SendInput {Raw}
(
__________                  __                __      __             __
\______   \_____  ___  ____/  |_  ___________/  \    /  \___________|  | __  ______
 |    |  _/\__  \ \  \/  /\   __\/ __ \_  __ \   \/\/   /  _ \_  __ \  |/ / /  ___/
 |    |   \ / __ \_>    <  |  | \  ___/|  | \/\        (  <_> )  | \/    <  \___ \
 |______  /(____  /__/\_ \ |__|  \___  >__|    \__/\  / \____/|__|  |__|_ \/____  >
        \/      \/      \/           \/             \/                   \/     \/
------------------------------------------------------------------------------------
                                                            (c) 1999-2021 T-Jah Tom

)

return

; Beispiel, ginge auch
; Numpad0 & Numpad1::MsgBox Sie haben Numpad1 gedrückt, während Sie Numpad0 gedrückt hielten.
; Numpad0 & Numpad2::Run Notepad
; <^>!m::MsgBox Sie haben ALTGR+M gedrückt.
; <^<!m::MsgBox Sie haben STRGLinks+ALTLinks+M gedrückt.


#If
; ---------------------------------------------------------------------------------->
; ---------------------------------------------------------------------------------->
