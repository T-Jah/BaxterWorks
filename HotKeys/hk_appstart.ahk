;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxterWorks Software | T-Jah Tom | HotKeys Apps und Funktionen			  	               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;     Version 001

#SingleInstance force 			; oder off
#NoEnv
SetWorkingDir %A_ScriptDir%		; wichtig
SendMode Input

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   HotKeys     [Version 001]                                                                                │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

;----------------------------------------------------------STRG+

^0::Run, https://ahkde.github.io/docs/commands/index.htm 	; STRG + 0
^2::Bax_Keys_Create()						; STRG + 2
^4::Run, %Bax_Start%\Apps\BWAppBar\BWAppBar.exe			; STRG + 4
^5::Run, %Bax_Start%\Apps\SuchBax\SuchBax.exe			; STRG + 5


;----------------------------------------------------------STRG+SHIFT+

^+1::Run, %Bax_Start%\Apps\GetReadyBax\GetReadyBax.exe 		; STRG + Shift + 1
^+2::Run, %Bax_Start%\Apps\NumpadZeichner\NumpadZeichner.exe	; STRG + Shift + 2
^+3::Run, %Bax_Start%\Apps\CaptureBax\CaptureBax.exe		; STRG + Shift + 3
^+4::Run, %Bax_Start%\Apps\IconExtract\IconExtractor.exe	; STRG + Shift + 4
^+0::Run, %Bax_Flex%						; STRG + Shift + 0


^+d::Run, %Bax_Start%\Apps\DesktopPainter\DesktopPainter.exe	; STRG + Shift + D
^+e::Run, %Bax_Start%\Apps\Emoji\EmojiMenu.exe			; STRG + Shift + E
^+f::Run, %Bax_Start%\Apps\FavFolders\FavoriteFolders.exe	; STRG + Shift + F
^+m::Run, %Bax_Start%\Apps\MiniDB\MiniDBs.exe	        	; STRG + Shift + M
^+n::Bax_2Win_start() 						; STRG + Shift + N
^+w::Run, %Bax_Start%\Apps\Würfel\neArtWürfel.exe		; STRG + Shift + W
^#!d::Bax_DropperGui_Create()					; STRG + Win + Alt +D


^+r::BaxFunk_reloadAHK() 					; STRG + Shift + R
 {
    DetectHiddenWindows, On
    SetTitleMatchMode, 2
    WinGet, allAhkExe, List, ahk_class AutoHotkey
    Loop, % allAhkExe {
        hwnd := allAhkExe%A_Index%
        if (hwnd = A_ScriptHwnd)  ; Verhindert das Neuladen des aktuellen Fensters
        {
            continue
        }
        PostMessage, 0x0111, 65303,,, % "ahk_id" . hwnd
    }
    Reload
}

^+u::Run, %Bax_Start%\Apps\UhrDigiSimple\UhrDigiSimple.exe ; STRG + Shift + u

;----------------------------------------------------------STRG+WIN

; Lib/funk_panic include
^#p::AHKPanic(3) 					; STRG + Win + P


^+k::
{
Run, %Bax_Start%\Apps\KillerBax\KillerBax.exe 			; STRG + Shift + k
Run, %Bax_Start%\Apps\KillerBax\KillerBaxAHK.exe 		; STRG + Shift + k
}
