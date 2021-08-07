CodeVersion := "1.0.0.4", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\pic.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, Tic und die Gdib-Autoren
;@Ahk2Exe-SetDescription DektopPainter - BildschirmNotizen
;@Ahk2Exe-SetFileVersion 1.0.0.4
;@Ahk2Exe-SetProductVersion 1.0.0.4
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks DektopPainter
;@Ahk2Exe-SetProductName DektopPainter

#SingleInstance, Force
DetectHiddenWindows, On
#NoEnv
SetBatchLines, -1
Coordmode, Pixel, Screen
Coordmode, Mouse, Screen

AppName = DesktopPainter
VersionNum := CodeVersion

ColourN = Red|Green|Blue
ColourH = ffff0000|ff00ff00|ff0000ff
StringSplit, ColourN, ColourN, |
StringSplit, ColourH, ColourH, |

SW := 50
BackColour := 0xff475155

#Include, %A_ScriptDir%\..\..\Lib\Gdip_all.ahk

If !pToken := Gdip_Startup()
{
	MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
	ExitApp
}
OnExit, Exit

Menu, Tray, NoStandard
Menu, Tray, DeleteAll
Menu, Tray, Add, Toggle Notes, ToggleNotes
Menu,Tray,Add,&Credits...,Credits
Menu,Tray,Add,&Hilfe...,HilfeTray
Menu, Tray, Add
Menu, Tray, Add, Exit, Exit

Menu, Tray, Default, Toggle Notes

SysGet, MonitorPrimary, MonitorPrimary
SysGet, WA, MonitorWorkArea, %MonitorPrimary%
WAWidth := WARight-WALeft, WAHeight := WABottom-WATop

Gui, 1: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs
Gui, 1: Show, NA Hide
hwnd1 := WinExist()

Gui, 2: -Caption +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs +Owner1
hwnd2 := WinExist()
Gui, 2: Color, 475155

Gui, 2: Add, Button, x135 y10 w50 gSave Default, &Save...
Loop, %ColourN0%
{
	Gui, 2: Add, Picture, % ((A_Index = 1) ? "x15 y+10" : "x+10 yp+0") " w" SW " h" SW " gChangeColour 0xE v" ColourH%A_Index% " hwnd" ColourN%A_Index%
	
	pBrush := Gdip_BrushCreateSolid("0x" ColourH%A_Index%)
	pBitmap := Gdip_CreateBitmap(SW, SW), G := Gdip_GraphicsFromImage(pBitmap)
	Gdip_FillRectangle(G, pBrush, 0, 0, SW, SW)
	hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
	hwnd := ColourN%A_Index%, SetImage(%hwnd%, hBitmap)
	
	Gdip_DeleteBrush(pBrush), Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
}
Gui, 2: Add, Picture, % "x75 y+30 w" SW " h" SW " 0xE hwndPreview"		;%
Gui, 2: Add, Slider, x10 y+40 w180 vPenWidth Tooltip Range1-30 gUpdatePreview, 12
ChosenColour := 0xffff0000
GoSub, UpdatePreview

Gui, 2: Show, w200 h250 x20 y20 NA Hide

pBitmapDraw := Gdip_CreateBitmap(WAWidth, WAHeight), GDrawplus := Gdip_GraphicsFromImage(pBitmapDraw)
Gdip_SetSmoothingMode(GDrawplus, 4)
pBrush := Gdip_BrushCreateSolid(0x01ffffff)
Gdip_FillRectangle(GDrawplus, pBrush, 0, 0, WAWidth, WAHeight)
Gdip_DeleteBrush(pBrush)

hbmDraw := CreateDIBSection(WAWidth, WAHeight), hdcDraw := CreateCompatibleDC(), obmDraw := SelectObject(hdcDraw, hbmDraw), GDraw := Gdip_GraphicsFromHDC(hdcDraw)
Gdip_DrawImage(GDraw, pBitmapDraw, 0, 0, WAWidth, WAHeight)

UpdateLayeredWindow(hwnd1, hdcDraw, WALeft, WATop, WAWidth, WAHeight)

Gdip_DeleteGraphics(GDraw), SelectObject(hdcDraw, obmDraw), DeleteObject(hbmDraw), DeleteDC(hdcDraw)
Return

;####################################################################################

Save:
Gui, 2: +OwnDialogs
FileSelectFolder, OutFolder,,, Speicherort aussuchen
If !OutFolder
Return
Gdip_SaveBitmapToFile(pBitmapDraw, OutFolder "\" A_Now ".png")
Return

;####################################################################################

UpdatePreview:
Gui, 2: Submit, NoHide

pBrush := Gdip_BrushCreateSolid(ChosenColour)
pBrushBack := Gdip_BrushCreateSolid(BackColour)
pBitmap := Gdip_CreateBitmap(SW, SW), G := Gdip_GraphicsFromImage(pBitmap), Gdip_SetSmoothingMode(G, 4)
Gdip_FillRectangle(G, pBrushBack, -2, -2, SW+4, SW+4)
Gdip_FillEllipse(G, pBrush, (SW-PenWidth)//2, (SW-PenWidth)//2, PenWidth, PenWidth)
hBitmap := Gdip_CreateHBITMAPFromBitmap(pBitmap)
SetImage(Preview, hBitmap)

Gdip_DeleteBrush(pBrushDraw), Gdip_DeletePen(pPenDraw)
pBrushDraw := Gdip_BrushCreateSolid(ChosenColour), pPenDraw := Gdip_CreatePen(ChosenColour, PenWidth)

Gdip_DeleteBrush(pBrush), Gdip_DeleteBrush(pBrushBack), Gdip_DeleteGraphics(G), Gdip_DisposeImage(pBitmap), DeleteObject(hBitmap)
Return

;####################################################################################

ChangeColour:
ChosenColour := "0x" A_GuiControl
GoSub, UpdatePreview
Return

;####################################################################################

WM_LBUTTONDOWN()
{
	Global

	If (A_Gui != 2)
	Return, -1	
	PostMessage, 0xA1, 2
	Drag := 1
}

;####################################################################################

ToggleNotes:
v := IsWindowVisible(hwnd1) || IsWindowVisible(hwnd2)
Gui, % "2: " (v ? "Hide" : "Show")			;%
Gui, % "1: " (v ? "Hide" : "Show")			;%
SetTimer, CheckPos, % (v ? "Off" : 20)		;%
Return

;####################################################################################

CheckPos:
MouseGetPos, x, y, Win
OnMessage(0x201, (Win = hwnd2) ? "WM_LBUTTONDOWN" : "")
If !GetKeyState("LButton", "P")
Drag := 0
If (Win != hwnd1) || !GetKeyState("LButton", "P") || Drag
{
	Ox := Oy := ""
	Return
}

hbmDraw := CreateDIBSection(WAWidth, WAHeight), hdcDraw := CreateCompatibleDC(), obmDraw := SelectObject(hdcDraw, hbmDraw), GDraw := Gdip_GraphicsFromHDC(hdcDraw)
Gdip_FillEllipse(GDrawplus, pBrushDraw, x-(PenWidth//2), y-(PenWidth//2), PenWidth, PenWidth)
Gdip_DrawLine(GDrawplus, pPenDraw, Ox ? Ox : x, Oy ? Oy : y, x, y)

Gdip_DrawImage(GDraw, pBitmapDraw, 0, 0, WAWidth, WAHeight)
UpdateLayeredWindow(hwnd1, hdcDraw, WALeft, WATop, WAWidth, WAHeight)

Gdip_DeleteGraphics(GDraw), SelectObject(hdcDraw, obmDraw), DeleteObject(hbmDraw), DeleteDC(hdcDraw)
Ox := x, Oy := y
Return

;####################################################################################

IsWindowVisible(hwnd)
{
	Return, DllCall("IsWindowVisible", "UInt", hwnd)
}

;####################################################################################

HilfeTray:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help.htm, %A_ScriptDir%\..\..\Files\help.htm
	}
	run,%A_ScriptDir%\..\..\Files\help.htm
	return

Credits:
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/Credits.htm, %A_ScriptDir%\..\..\Files\Credits.htm
	}
	run, %A_ScriptDir%\..\..\Files\Credits.htm
	return


Exit:
Gdip_DeleteBrush(pBrushDraw), Gdip_DeletePen(pPenDraw)
Gdip_DeleteGraphics(GDrawplus), Gdip_DisposeImage(pBitmapDraw)
Gdip_Shutdown(pToken)
ExitApp
Return