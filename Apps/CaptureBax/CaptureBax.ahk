CodeVersion := "1.0.0.7", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\schere.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright Rajat
;@Ahk2Exe-SetDescription Screencapture Tool
;@Ahk2Exe-SetFileVersion 1.0.0.7
;@Ahk2Exe-SetProductVersion 1.0.0.7
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks CaptureBax
;@Ahk2Exe-SetProductName CaptureBax
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
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 009              M.i.n.i.Bax AHK Skript

/*
 * CaptureBax
 * Copyright 2021 T-Jah Tom
 * All Rights Reserved.
 * Use, reproduction, distribution, and modification of this code is subject to the terms and
 * conditions of the MIT license, available at http://www.opensource.org/licenses/mit-license.php
 *
 * Author: T-Jah Tom
 * Project: https://github.com/T-Jah
 *
 * ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * │  MiniBax Skriptoptionen 	(lang)                 [Version 005]                                            │
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
	Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\schere.ico	; #NoTrayIcon

; OnExit
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk

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
	AppName = CaptureBax
	Bax_help = help_capturebax	
	Skriptvorlage = MiniBax_009
	Bax_Icon = %Bax_Start%\Grafix\schere.ico
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

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax AppStart mit Subanweisung         [Version 003]                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


;---------------------------------------------------------------->
; AppStart (AutoExec Bereich geht nach dem letzten Eintrag weiter)
; Also hier nach Traymenü. Endet ggf mit return nach den includes
;---------------------------------------------------------------->

	GoSub,INIDELETE
	GoSub,INIREAD
	GoSub,INIWRITE
	GoSub,TRAYMENU
	


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  Includes (Ende Autoexec)        [Version 008]                                                     │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

#Persistent  							; Verhindert, dass sich das Skript automatisch beendet.
; --------------------------------------------------------------- TextBox für die Fehlersuche
; MsgBox, %Bax_ScriptStart%

; BaxFunk Module
	; #Include %A_ScriptDir%\..\..\Function\BaxFunk_FensterInfo.ahk	
	; #Include %A_ScriptDir%\..\..\Function\BaxFunk_IconShow.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_LicenceWindow.ahk	
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_2Win.ahk
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Dropper.ahk
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_ConfigWindow.ahk
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_reloadAHK.ahk
	#Include %A_ScriptDir%\..\..\Lib\datecalc.ahk
	#include %A_ScriptDir%\..\..\Lib\funk_panic.ahk
	#Include %A_ScriptDir%\..\..\Lib\funk_toggle.ahk
	#Include %A_ScriptDir%\..\..\Lib\Gdip_all.ahk
	#Include %A_ScriptDir%\..\..\Lib\ipfindmap.ahk
	#Include %A_ScriptDir%\..\..\Lib\keepalive.ahk
	#Include %A_ScriptDir%\..\..\Lib\MouseisOver.ahk
	#Include %A_ScriptDir%\..\..\Lib\ObjCSV.ahk
	#Include %A_ScriptDir%\..\..\Lib\tf.ahk
	#Include %A_ScriptDir%\..\..\Lib\toggle_hiddenfiles.ahk
	#Include %A_ScriptDir%\..\..\Lib\toggle_lightdark.ahk


	;Gdip_Startup()
	
;-------------------------------------------------------Ende AutoExec
	return
;-------------------------------------------------------Ende AutoExec

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax GUI, Traymenü             [Version 001]                                                           │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

TRAYMENU:
Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray,NoMainWindow
Menu,Tray,Add,%AppName%,OpenGUI
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
Menu,Tray,Tip,%AppName% %Codeversion%
Menu,Tray,Default,%AppName%
return


;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax GUI, Dateimenü, kein return        [Version 000]                                                  │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  GUI, Fenster, Teil 1 [Version 000]                                                                │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;



; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  GUI, Fenster, Teil 2 [ohne Versionsnummer]                                                        │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


	return


; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax GUI, TrayFensterFenster (About), ein Label vom Traymenü      [Version 001]                        │
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
Gui,99:Add,Text, R3 ,CaptureBax basiert auf dem Skript von Rajat.`nEs stammt aus dem offiziellen Handbuch und ist von mir editiert`nFunktioniert
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

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax HotKeys     [Version 001]                                                                         │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

^X::
StartSelection() {
   Hotkey, LButton, Select, On
   ReplaceSystemCursors("IDC_CROSS")
}

Select() {
   static hGui := CreateSelectionGui()
   hHook := SetHook(WH_MOUSE_LL := 14, "LowLevelMouseProc", hGui)
   KeyWait, LButton
   ReplaceSystemCursors("")
   Hotkey, LButton, Off
   SetHook(hHook)
   WinGetPos, X, Y, W, H, ahk_id %hGui%
   Gui, %hGui%:Show, Hide
   ShowSketch(X, Y, W, H)
}

ShowSketch(X, Y, W, H) {
   static oBitmap := [], hParent, hSketch := CreateSketchGui(800, 600, hParent, oBitmap), hPic, hBM
   ( hBM && DllCall("DeleteObject", Ptr, hBM) )
   ( hPic && DllCall("DestroyWindow", Ptr, hPic) )
   hBM := HBitmapFromScreen(X, Y, W, H)
   oBitmap[1] := hBM
   GetDimensions(800, 600, X, Y, W, H)
   try Gui, %hSketch%: Add, Pic, hwndhPic x%X% y%Y% w%W% h%H%, HBITMAP:*%hBM%
   Gui, %hParent%: Show
}

GetDimensions(maxWidth, maxHeight, ByRef X, ByRef Y, ByRef W, ByRef H) {
   if (W > maxWidth || H > maxHeight) {
      maxRatio := maxWidth/maxHeight
      ratio := W/H
      if (maxRatio > ratio) {
         H := maxHeight
         W := H*ratio
         X := (maxWidth - W)/2
         Y := 0
      }
      else {
         W := maxWidth
         H := W/ratio
         X := 0
         Y := (maxHeight - H)/2
      }
   }
   else {
      X := (maxWidth - W)/2
      Y := (maxHeight - H)/2
   }
}
   
SetHook(hook, fn := "", eventInfo := "", isGlobal := true) {
   static exitFunc
   if !fn {
      DllCall("UnhookWindowsHookEx", "Ptr", hook)
      OnExit(exitFunc, 0)
      exitFunc := ""
   }
   else {
      hHook := DllCall("SetWindowsHookEx", "Int", hook, "Ptr", RegisterCallback(fn, "Fast", 3, eventInfo)
                                         , "Ptr", DllCall("GetModuleHandle", "UInt", 0, "Ptr")
                                         , "UInt", isGlobal ? 0 : DllCall("GetCurrentThreadId"), "Ptr")
      ( exitFunc && OnExit(exitFunc, 0) )
      exitFunc := Func(A_ThisFunc).Bind(hHook, "", "")
      OnExit(exitFunc)
      Return hHook
   }
}

LowLevelMouseProc(nCode, wParam, lParam) {
   static WM_MOUSEMOVE := 0x200, WM_LBUTTONUP := 0x202
        , coords := [], startMouseX, startMouseY, hGui
        , timer := Func("LowLevelMouseProc").Bind("timer", "", "")
   
   if (nCode = "timer") {
      while coords[1] {
         point := coords.RemoveAt(1)
         mouseX := point[1], mouseY := point[2]
         x := startMouseX < mouseX ? startMouseX : mouseX
         y := startMouseY < mouseY ? startMouseY : mouseY
         w := Abs(mouseX - startMouseX)
         h := Abs(mouseY - startMouseY)
         try Gui, %hGUi%: Show, x%x% y%y% w%w% h%h% NA
      }
   }
   else {
      (!hGui && hGui := A_EventInfo)
      if (wParam = WM_LBUTTONUP)
         startMouseX := startMouseY := ""
      if (wParam = WM_MOUSEMOVE)  {
         mouseX := NumGet(lParam + 0, "Int")
         mouseY := NumGet(lParam + 4, "Int")
         if (startMouseX = "") {
            startMouseX := mouseX
            startMouseY := mouseY
         }
         coords.Push([mouseX, mouseY])
         SetTimer, % timer, -10
      }
      Return DllCall("CallNextHookEx", Ptr, 0, Int, nCode, UInt, wParam, Ptr, lParam)
   }
}

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax Funktionen Standard [Version 002]      Tooltips immer unterschiedlich                             │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


;  
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  Funktionen von diesem Skript                                                                      │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


ReplaceSystemCursors(IDC = "")
{
   static IMAGE_CURSOR := 2, SPI_SETCURSORS := 0x57
        , exitFunc := Func("ReplaceSystemCursors").Bind("")
        , SysCursors := { IDC_APPSTARTING: 32650
                        , IDC_ARROW      : 32512
                        , IDC_CROSS      : 32515
                        , IDC_HAND       : 32649
                        , IDC_HELP       : 32651
                        , IDC_IBEAM      : 32513
                        , IDC_NO         : 32648
                        , IDC_SIZEALL    : 32646
                        , IDC_SIZENESW   : 32643
                        , IDC_SIZENWSE   : 32642
                        , IDC_SIZEWE     : 32644
                        , IDC_SIZENS     : 32645 
                        , IDC_UPARROW    : 32516
                        , IDC_WAIT       : 32514 }
   if !IDC {
      DllCall("SystemParametersInfo", UInt, SPI_SETCURSORS, UInt, 0, UInt, 0, UInt, 0)
      OnExit(exitFunc, 0)
   }
   else  {
      hCursor := DllCall("LoadCursor", Ptr, 0, UInt, SysCursors[IDC], Ptr)
      for k, v in SysCursors  {
         hCopy := DllCall("CopyImage", Ptr, hCursor, UInt, IMAGE_CURSOR, Int, 0, Int, 0, UInt, 0, Ptr)
         DllCall("SetSystemCursor", Ptr, hCopy, UInt, v)
      }
      OnExit(exitFunc)
   }
}

CreateSelectionGui() {
   Gui, New, +hwndhGui +Alwaysontop -Caption +LastFound +ToolWindow +E0x20 -DPIScale
   WinSet, Transparent, 130
   Gui, Color, FFC800
   Return hGui
}

CreateSketchGui(W, H, ByRef hParent, oBitmap) {
   Gui, New, +hwndhParent, Sketch
   Gui, Color, DDDDDD
   Gui, Add, Button, % "x" W + 10 - 80 " y" H + 20  " w80", Save
   handler := Func("SaveBitmapToFile").Bind(oBitmap)
   GuiControl, +g, Button1, % handler
   Gui, New, +hwndhSketch +Parent%hParent% +ToolWindow -Caption +Border
   Gui, Color, 808080
   Gui, Show, NA x10 y10 w%W% h%H%
   Gui, %hParent%: Show, Hide w820 h653
   Return hSketch
}

SaveBitmapToFile(oBitmap) {
   FileSelectFile, filePath, 16,, Save the image as:, Images (*.png; *.bmp; *.tiff; *.tif; *.jpeg; *.jpg; *.gif)
   if !filePath
      Return
   oGdip := new GDIp
   pBitmap := oGdip.CreateBitmapFromHBITMAP(oBitmap[1])
   oGdip.SaveBitmap(pBitmap, filePath)
   oGdip.DisposeImage(pBitmap)
}

HBitmapFromScreen(X, Y, W, H) {
   HDC := DllCall("GetDC", "Ptr", 0, "UPtr")
   HBM := DllCall("CreateCompatibleBitmap", "Ptr", HDC, "Int", W, "Int", H, "UPtr")
   PDC := DllCall("CreateCompatibleDC", "Ptr", HDC, "UPtr")
   DllCall("SelectObject", "Ptr", PDC, "Ptr", HBM)
   DllCall("BitBlt", "Ptr", PDC, "Int", 0, "Int", 0, "Int", W, "Int", H
                   , "Ptr", HDC, "Int", X, "Int", Y, "UInt", 0x00CC0020)
   DllCall("DeleteDC", "Ptr", PDC)
   DllCall("ReleaseDC", "Ptr", 0, "Ptr", HDC)
   Return HBM
}

class GDIp  {
   __New() {
      if !DllCall("GetModuleHandle", Str, "gdiplus", Ptr)
         DllCall("LoadLibrary", Str, "gdiplus")
      VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
      DllCall("gdiplus\GdiplusStartup", UPtrP, pToken, Ptr, &si, Ptr, 0)
      this.token := pToken
   }
   
   __Delete()  {
      DllCall("gdiplus\GdiplusShutdown", Ptr, this.token)
      if hModule := DllCall("GetModuleHandle", Str, "gdiplus", Ptr)
         DllCall("FreeLibrary", Ptr, hModule)
   }

   CreateBitmapFromHBITMAP(hBitmap, Palette=0)  {
      DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", Ptr, hBitmap, Ptr, Palette, PtrP, pBitmap)
      return pBitmap
   }

   SaveBitmap(pBitmap, ByRef info, tobuff := false, JPEGquality := 75)
   {
      ; info: if copy to the buffer, specify the file extansion, if to the file — the file path
      if tobuff
         Extension := info
      else
         SplitPath, info,,, Extension
      if Extension not in BMP,DIB,RLE,JPG,JPEG,JPE,JFIF,GIF,TIF,TIFF,PNG
         return -1

      DllCall("gdiplus\GdipGetImageEncodersSize", UintP, nCount, UintP, nSize)
      VarSetCapacity(ci, nSize)
      DllCall("gdiplus\GdipGetImageEncoders", UInt, nCount, UInt, nSize, Ptr, &ci)
      if !(nCount && nSize)
         return -2
      
      Loop, % nCount  {
         sString := StrGet(NumGet(ci, (idx := (48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize), "UTF-16")
         if !InStr(sString, "*." Extension)
            continue
         
         pCodec := &ci+idx
         break
      }
      
      if !pCodec
         return -3
      
      if RegExMatch(Extension, "i)^J(PG|PEG|PE|FIF)$") && JPEGquality != 75  {
         DllCall("gdiplus\GdipGetEncoderParameterListSize", Ptr, pBitmap, Ptr, pCodec, UintP, nSize)
         VarSetCapacity(EncoderParameters, nSize, 0)
         DllCall("gdiplus\GdipGetEncoderParameterList", Ptr, pBitmap, Ptr, pCodec, UInt, nSize, Ptr, &EncoderParameters)
         Loop, % NumGet(EncoderParameters, "UInt")
         {
            elem := (24+A_PtrSize)*(A_Index-1) + 4 + (pad := A_PtrSize = 8 ? 4 : 0)
            if (NumGet(EncoderParameters, elem+16, "UInt") = 1) && (NumGet(EncoderParameters, elem+20, "UInt") = 6)
            {
               p := elem+&EncoderParameters-pad-4
               NumPut(JPEGquality, NumGet(NumPut(4, NumPut(1, p+0)+20, "UInt")), "UInt")
               break
            }
         }      
      }
      if !tobuff
         E := DllCall("gdiplus\GdipSaveImageToFile", Ptr, pBitmap, WStr, info, Ptr, pCodec, UInt, p ? p : 0)
      else  {
         DllCall( "ole32\CreateStreamOnHGlobal", UInt, 0, Int, 1, PtrP, pStream )
         if !E := DllCall( "gdiplus\GdipSaveImageToStream", Ptr, pBitmap, Ptr, pStream, Ptr, pCodec, UInt, p ? p : 0 )  {
            DllCall( "ole32\GetHGlobalFromStream", Ptr, pStream, PtrP, hData )
            pData := DllCall( "GlobalLock", Ptr, hData, Ptr )
            nSize := DllCall( "GlobalSize", Ptr, hData, Ptr )
            VarSetCapacity( info, 0), VarSetCapacity( info, nSize, 0 )
            DllCall( "RtlMoveMemory", Ptr, &info, Ptr, pData, UInt, nSize )
            DllCall( "GlobalUnlock", Ptr, hData )
            DllCall( "GlobalFree", Ptr, hData )
         }
         ObjRelease(pStream)
      }
      return E ? -4 : tobuff ? nSize : 0
   }
   
   DisposeImage(pBitmap)  {
      return DllCall("gdiplus\GdipDisposeImage", Ptr, pBitmap)
   }
}

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  Sub Ini  [Version 004]                                                                            │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

INIDELETE:
	IniDelete, %scriptini%, Nutzerinfo, 

INIREAD:
	IniRead, Bax_IP , %homeini%, Netzinfo, Letzte IP, %A_Space%
	IniRead, Ziel1, %userini%, Dropper, Ziel1, %A_Space% 
	IniRead, Ziel2, %userini%, Dropper, Ziel2, %A_Space% 
	IniRead, DeinOrdner1, %userini%, 2Win, DeinOrdner1, %A_Space% 
	IniRead, DeinOrdner2, %userini%, 2Win, DeinOrdner2, %A_Space% 
	IniRead, Bax_JobDir, %userini%, Variablen, Bax_JobDir, %A_Space% 
	IniRead, Bax_Flex, %userini%, Variablen, Bax_Flex, %A_Space% 

INIWRITE:
	IniWrite, %LetzteAnmeldung% , %scriptini%, Nutzerinfo, Letzter Nutzer
	IniWrite, %LetzterEinsatz% , %scriptini%, Nutzerinfo, Letzter Rechner
	IniWrite, %Bax_IP% , %scriptini%, Nutzerinfo, Bax_IP
	IniWrite, %FensterVersion% , %scriptini%, Nutzerinfo, FensterVersion
	IniWrite, %A_Now%_%AppName% , %scriptini%, Stats_%BaxNutzerName% , LastLogIn

return

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  Subs GUI-Fenster       [Version 001]                                                              │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax Subs Dateimenü     [Version 003]                                                                  │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │ MiniBax  Subs Traymenü    [Version 003]         wenn ohne GUI, OpenGUI auf About                           │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

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
	; Bax_ConfigGui_Create()
	return

EINSTELLUNGEN:
	Run,%scriptini%
	Return

Variablen:
	ListVars
	return

Version:
	Run,%Bax_Start%\Log\Versionsinfo_%AppName%.txt
	return
HotKeys:
	ListHotkeys
	return

Reload:
	reload
	return

OpenGUI:
	;Gui, Show, Center Autosize, %AppName%
	GoSub,About
	return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MiniBax Subs Aboutfenster        [Version 002]                                                            │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

BWApp:
  	Run,http://www.baxterworks.de/software/hilfe/%Bax_help%.htm,,UseErrorLevel
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
; │ MiniBax  EndSub          [Version 007]        +gdib aus                                                    │
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
ButtonCancel:			; falls es einen Button gibt
GuiEscape:
CleanUp:
SavePosition:
DateiBeenden:     		; Benutzer hat "Exit" im Dateimenü ausgewählt.
	IniWrite, %Lastseen% , %backuptxt%, Stats_%BaxNutzerName% , Lastseen
	IniWrite, %A_Now%_%AppName% , %backuptxt%, Stats_%BaxNutzerName% , LastLogIn
	IniWrite, %AppName%_%CodeVersion%_%Skriptvorlage%_%A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzung_%AppName%
	FileAppend, Nutzung: %A_Now% %A_Tab% Nutzer: %BaxNutzerName%  %A_Tab% App: %AppName%`n , %Bax_Start%\Config\%A_ComputerName%.bax
	DetectHiddenWindows On
	WinGetPos, X, Y, %AppName%
	If (x > 0)
	IniWrite, % " x" X " y" Y, %scriptini%, Position, %AppName%_Position
 	IniWrite, 0, %scriptini%, Schalter, %AppName%_FensterInfo
	; SoundPlay, NoFile.wav
   	Gui, Destroy			; gibt die Ressource frei
	SoundBeep, 750, 500
  	CTLCOLORS.Free()		; wenn classCTLColours benutzt wurde
	;Gdip_Shutdown(pToken)		; wird in includes gestartet

	if FileExist("..\..\Files\*.htm")
	FileDelete %Bax_Start%\Files\*.htm

ExitApp
