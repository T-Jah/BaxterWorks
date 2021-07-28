;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxterWorks Software | T-Jah Tom | Funktionen | Aufruf mit: Bax_LicenceGui_Create()   	               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;     Version 005




Bax_LicenceGui_Create(){
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
	UrlDownloadToFile, http://www.baxterworks.de/software/pix/bw_banner.png, Grafix\bw_banner.png
	UrlDownloadToFile, http://www.baxterworks.de/software/pix/bw_software2.png, Grafix\bw_software2.png
}


;-------------------------------------------------------------------------
; Licence GUI Version 003
;-------------------------------------------------------------------------

Gui,Licence:New
Gui,Licence:+Owner  ; Definiert Dropper als Unterfenster vom Hauptfenster des Skripts, um dessen Taskleistenschaltfläche zu verstecken.
Gui,Licence:Margin,20,20
Gui,Licence:Color, Black
Gui,Licence:Font, s14 cLime, Verdana
Gui,Licence:Add,Picture, x0 y0, %Bax_Start%\Grafix\bw_banner.png
Gui,Licence:Add,Text, R1 x20 ,MIT Licence
Gui,Licence:Font
Gui,Licence:Font, s11 cWhite, Verdana
Gui,Licence:Add,Text, x20 y+40 ,Einige Teile des Codes stammen aus dem offiziellen Handbuch und aus dem Forum.`nIch nutze weiterhin Libarys von versierten Programmierern, denen ich danken möchte,`ndass sie ihr Wissen im Netz teilen. Selbstverständlich sind alle originalen Hinweise enthalten.`nWeitergehende Hinweise finden sich in den jeweiligen Programmteilen. Meinen eigenen Code`nstelle ich unter dieser Lizenz online:`n 
Gui,Licence:Add,Text, x20 y+20 , MIT LICENSE`n(c) 2021 T-Jah Tom <tom.besch@gmx.de>`n`nPermission is hereby granted, free of charge, to any person obtaining a copy`nof this software and associated documentation files (the "Software"), to deal`nin the Software without restriction, including without limitation the rights`nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell`ncopies of the Software, and to permit persons to whom the Software is`nfurnished to do so, subject to the following conditions:`n`nThe above copyright notice and this permission notice shall be included in all`ncopies or substantial portions of the Software.`n`nTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR`nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,`nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE`nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER`nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,`nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE`nSOFTWARE..`n
Gui,Licence:Add, Button, xm gExitLicenceWithoutSaving, Fenster schließen
Gui,Licence:Add, Button, x+2 gCreditsknopf, Credits
Gui,Licence:Font
Gui,Licence:Show, x400 y20 w800, BaxterWorks Software Licence
OnMessage(0x200, "LicenceToolTips")
return

;-------------------------------------------------------------------------
; Subs und Label Version 001
;-------------------------------------------------------------------------

Creditsknopf:
run, http://www.baxterworks.de/software/hilfe/Credits.htm
return
            

ExitLicenceWithoutSaving:
WinClose
Gui, Licence:Destroy
Return
}

LicenceToolTips() {
MouseGetPos,,,, VarControl
IfEqual, VarControl, Button1
	Message := "Schließe das Fenster, ohne das Programm zu beenden."
else IfEqual, VarControl, Button2
	Message := "Ehre, wem Ehre gebührt!"
else IfEqual, VarControl, Picture1
	Message := "Schließe das Fenster, ohne das Programm zu beenden."
ToolTip % Message
}
