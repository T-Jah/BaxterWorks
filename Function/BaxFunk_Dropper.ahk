;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxterWorks Software | T-Jah Tom | Funktionen | Aufruf mit: Bax_DropperGui_Create()  	               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;     Version 007



Bax_DropperGui_Create(){
global
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %Bax_Start%
		FileEncoding UTF-8
		#SingleInstance ignore

; If the images we want to work with do not exist on disk, then download them...
; ggf nur mit include gdib, von tic

If !(FileExist(File1) && FileExist(File2))
{
	UrlDownloadToFile, http://www.baxterworks.de/software/pix/bw_banner.png,  Grafix\bw_banner.png
	UrlDownloadToFile, http://www.baxterworks.de/software/pix/bw_software2.png,  Grafix\bw_software2.png
}

GoSub, IniReadDrop

Gui,Dropper:New
Gui,Dropper:+DPIScale +E0x10 -ToolWindow -MaximizeBox +Resize -Owner +OwnDialogs -Border  ; Definiert Dropper als Unterfenster vom Hauptfenster des Skripts, um dessen Taskleistenschaltfläche zu verstecken.
Gui,Dropper:Margin,20,20
Gui,Dropper:Color, Black
Gui,Dropper:Font, s14 cLime, Verdana
Gui,Dropper:Add,Picture, x0 y0, %Bax_Start%\Grafix\bw_banner.png
Gui,Dropper:Add,Text, R1 x20, Dropper
Gui,Dropper:Font
Gui,Dropper:Font, s11 cWhite, Verdana
Gui,Dropper:Add, Text, y+20 R2, Ziehe deine Datei hier hin`num sie zum Ziel zu verschieben.
Gui,Dropper:Add, Radio, x40 y+5 Checked vRadio1 , %DropZiel1%
Gui,Dropper:Add, Radio, x40 y+10 -Checked vRadio2 , %DropZiel2%
Gui,Dropper:Add, Button, xm gExitDropperWithoutSaving, Fenster schließen
Gui,Dropper:Add, Button, x+2 gCreditDropknopf, Credits
Gui,Dropper:Font
Gui,Dropper:Show, x400 y20 w600 center, BaxterWorks Software Dropper
WinSet, AlwaysOnTop, Toggle , Dropper
WinWait, Dropper
WinMove, 600, 600
OnMessage(0x200, "DropperToolTips")
return




CreditDropknopf:
run, %Bax_Start%\Files\Credits.md
return

DropperGuiDropFiles:
DroppedFile:=A_GuiEvent
Gui, Submit, NoHide

	If (Radio1 = 1)
	{
		DropTarget1:=DropZiel1
		msgbox, 4160, Dropper Bestätigung, %DropTarget1% ist das Ziel, 3
		IniWrite, %DropZiel1% , %userini% , UserVars, Ziel1
    		FileRead, content, %DroppedFile%
		FileGetSize, Wzeit, %DroppedFile%, K
   		filecopy, %DroppedFile% , %DropTarget1% 
    		filedelete, %DroppedFile%
	}
	if (Radio2 = 1)
	{
	   	DropTarget2:=DropZiel2
		msgbox, 4160, Dropper Bestätigung, %DropTarget2% ist das Ziel, 3
		IniWrite, %DropZiel2% , %userini% , UserVars, Ziel2
    		FileRead, content, %DroppedFile%
		FileGetSize, Wzeit, %DroppedFile%, K
   		filecopy, %DroppedFile% , %DropTarget2% 
    		filedelete, %DroppedFile%
	}

return



            

ExitDropperWithoutSaving:
WinClose
Gui, Dropper:Destroy
Return
}

DropperToolTips() {

MouseGetPos,,,, VarControl

IfEqual, VarControl, Button1

	Message := "Drop1, über die ini einstellen"

else IfEqual, VarControl, Button2

	Message := "Drop2, über die ini einstellen"

else IfEqual, VarControl, Button3

	Message := "Schließe das Fenster, ohne das Programm zu beenden."

else IfEqual, VarControl, Button4

	Message := "Ehre, wem Ehre gebührt!"


ToolTip % Message

}

IniReadDrop:
IniRead, DropZiel1 , %userini%, UserVars, Ziel1
IniRead, DropZiel2 , %userini%, UserVars, Ziel2
return