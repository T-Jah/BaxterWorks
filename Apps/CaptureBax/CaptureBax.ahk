CodeVersion := "1.0.1.2", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\schere.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright Rajat
;@Ahk2Exe-SetDescription Screencapture Tool
;@Ahk2Exe-SetFileVersion 1.0.1.2
;@Ahk2Exe-SetProductVersion 1.0.1.2
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
;   Direktiven nach ganz oben                     Vorlage GesamtVersion 016            M.a.c.r.o.Bax AHK Skript

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
 * │   Skriptoptionen  MacroBax                [Version 001]                                                    │
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
; │   MacroBax  Variablen, zB Pfade     [Version 004]                                                                    │
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
	Skriptvorlage = MacroBax_016
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
; │               Appstart MacroBax         [Version 002]                                                      │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;
	#Include %A_ScriptDir%\..\..\Function\BaxFunk_Stats.ahk

	GoSub, TRAYMENU
	GoSub,STATS

;-----Skript------------------------------------------


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
; │   Funktionen Standard [Version 001]    +                                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;



; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   Funktionen von diesem Skript                                                                             │
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

;-----Skriptende--------------------------------------
return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │  MacroBax Stats     [Version 004]                                                                           │
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

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   EndSub MacroBax        [Version 009]                                                                     │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


GuiEscape:
GuiClose:
ButtonCancel:
quit:
	IniWrite, %LetzteAnmeldung% , %scriptini%, Nutzerinfo, Letzter Nutzer
	IniWrite, %LetzterEinsatz% , %scriptini%, Nutzerinfo, Letzter Rechner
	IniWrite, %FensterVersion% , %scriptini%, Nutzerinfo, FensterVersion
	IniWrite, %Skriptvorlage% , %scriptini%, Nutzerinfo, Skriptvorlage
	IniWrite, %A_Now% , %scriptini%, Nutzerinfo, LastLogIn
	IniWrite, %A_Now% , %scriptini%, Stats_%BaxNutzerName% , LastLogInZeit

	FormatTime, LastSeen,, LongDate
	IniWrite, %Lastseen% , %backuptxt%, Stats_%BaxNutzerName% , Lastseen
	IniWrite, %A_Now%_%AppName% , %backuptxt%, Stats_%BaxNutzerName% , LastLogIn
	IniWrite, %AppName%_%CodeVersion%_%Skriptvorlage%_%A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzung_%AppName%
	IniWrite, %A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzzeit_%AppName%
FileAppend, Nutzung: %A_Now% %A_Tab% Nutzer: %BaxNutzerName% %A_Tab% App: %AppName%_%CodeVersion% %A_Tab% Skriptvorlage: %Skriptvorlage% %A_Tab% %Appnutzcount% Starts in %Nutzungstage% Tagen`n , %Bax_Start%\Files\Stats\%A_ComputerName%.txt
ExitApp

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   SubTray MacroBax         [Version 005]                                                                   │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

About:
	MsgBox, 64, About, Mehr über BaxterWorks Software findest du im Netz:`nhttp://www.BaxterWorks.de/software`nCredits an das offizielle Handbuch.`n`nDownload: https://github.com/T-Jah
	return

helptray:
If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/%Bax_help%.htm, %A_ScriptDir%\..\..\Files\%Bax_help%.htm
	}
	run,%A_ScriptDir%\..\..\Files\%Bax_help%.htm
	return
Credits:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/Credits.htm, %Bax_Start%\Files\Credits.htm
	}
	run, %Bax_Start%\Files\Credits.htm
	return
Version:
	Run,%Bax_Start%\Log\Versionsinfo_%AppName%.txt
	return
Reload:
	reload
	return

OpenGUI:
	Gui, Show, Center Autosize, %AppName%
	;GoSub,About
	return

; 
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   GUI, Traymenü   MacroBax            [Version 003]                                                        │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;

TRAYMENU:
	Menu, Tray, NoStandard
	Menu, Tray, DeleteAll
	Menu, Tray, NoMainWindow
	Menu, Tray, Add, %AppName%, OpenGUI
	Menu, Tray, Add						; Trennlinie
	Menu, Tray, Add, Über diese App, About
	Menu, Tray, Add, Hilfe, helptray
	Menu, Tray, Add, Versionsinfo, version
	Menu, Tray, Add, Credits, Credits
	Menu, Tray, Add
	Menu, Tray, Add, Reload, reload
	Menu, Tray, Add, Exit, quit
	Menu, Tray, Default, %AppName%
	Menu, Tray, Tip, %AppName%  %Codeversion%
	return
