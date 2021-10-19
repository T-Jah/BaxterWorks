BaxFunk_backuptxt()
 	{
global
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %Bax_Start%
		FileEncoding UTF-8
		#SingleInstance force

    	DetectHiddenWindows, On
    		;Send, ^a     ; lasse ich weg, damit nur das von mir markierte kopiert wird
    		;Sleep 100
    	Send, {Ctrl}{c}
  	BlockInput, Off

  	IfNotExist, %Bax_JobDir%\iSafeText
  	{
    	FileCreateDir, %Bax_JobDir%\iSafeText
  	}
	WinGetTitle, WindowName, A
	StringReplace, WindowName, WindowName, `\, -, All
  	StringReplace, WindowName, WindowName, `:, -, All

  	FileAppend , %clipboard%, %Bax_JobDir%\iSafeText\bw_%A_Now%.txt
return
}
