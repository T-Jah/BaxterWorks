;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxterWorks Software | T-Jah Tom | Funktionen | Aufruf mit: Bax_IconShow_Create()   	               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;     Version 007

Bax_IconShow_Create(){
global
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %Bax_Start%
		FileEncoding UTF-8
		#SingleInstance ignore
		

;-------------------------------------------------------------------------
; IconShow GUI Version 003
;-------------------------------------------------------------------------

Gui,IconShow:New
Gui,IconShow:+Owner  ; Definiert IconShow als Unterfenster vom Hauptfenster des Skripts, um dessen Taskleistenschaltfläche zu verstecken.
FileSelectFile, file, 32, %A_WinDir%\System32\shell32.dll, Pick a file to check icons., *.*
if file =
    return


Gui,IconShow:font, s14, Tahoma
Gui,IconShow:Add, ListView, h415 w150 gIconNum, Icon 
ImageListID := IL_Create(10,1,1)  ; Liste für 10 Icons.
LV_SetImageList(ImageListID,1)    ; ordnet die Liste der ListView zu.
Loop                              
   {
     Count := Image               ; Anzahl Icons
     Image := IL_Add(ImageListID, file, A_Index)  ; nur für ältere Windows Versionen nötig

     If (Image = 0)               ; Wenn hat fertig quasi
       Break                     
   } 
Loop, %Count%
	LV_Add("Icon" . A_Index, "     " . A_Index)
	LV_ModifyCol("AutoHdr")  ; Auto-adjust the column widths.
	LV_ModifyCol()
Menu, FileMenu, Add, Datei &öffnen`tCtrl+ö, OpenFile
Menu, IconShowMenuBar, Add, &Datei, :FileMenu 
Gui,IconShow:Menu, IconShowMenuBar
Gui,IconShow:Show,, IconShow
OnMessage(0x200, "IconShowToolTips")
return
}

return
;-------------------------------------------------------------------------
; Subs und Label Version 001
;-------------------------------------------------------------------------



IconShowToolTips() {
MouseGetPos,,,, VarControl
IfEqual, VarControl, Edit1
	Message := "Schließe das Fenster, ohne das Programm zu beenden."
else IfEqual, VarControl, LV1
	Message := "Ehre, wem Ehre gebührt!"
else IfEqual, VarControl, Picture1
	Message := "Schließe das Fenster, ohne das Programm zu beenden."
ToolTip % Message
}

OpenFile:
LV_Delete()
  FileSelectFile, file, 32,, Pick a file to check icons., *.*
ImageListID := IL_Create(10,1,1)  ; Create an ImageList to hold 10 small icons.
LV_SetImageList(ImageListID,1)    ; Assign the above ImageList to the current ListView.
Loop                              ; Load the ImageList with a series of icons from the DLL.
   {
     Count := Image               ; Number of icons found
     Image := IL_Add(ImageListID, file, A_Index)  ; Omits the DLL's path so that it works on Windows 9x too.

     If (Image = 0)               ; When we run out of icons
       Break                     
   } 
Loop, %Count%  ; Add rows to the ListView (for demonstration purposes, one for each icon).
    LV_Add("Icon" . A_Index, "     " . A_Index)
LV_ModifyCol("AutoHdr")  ; Auto-adjust the column widths.
LV_ModifyCol() 
Return

IconNum:
  Clipboard := file . ", " . A_EventInfo
  Msgbox %Clipboard% `r     added to Clipboard! `r %A_ScriptDir%
Return


IconShowGuiClose:  ; Exit the script when the user closes the ListView's GUI window.
	Gui,IconShow:Destroy
	SoundBeep, 750, 500
WinClose
