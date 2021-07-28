ListLines On

:c*:.vfl::VfL Bochum 1848
:c*:.smile::☺
:c*:.grad::° Celsius
:c*:.rec::🛑

:*:ccm3::ccm³
:*:qm2::qm²
:c*:fms::Fibromyalgiesyndrom (FMS)
:*:(a)::@
:*:(c)::©
:*:(t)::†
:*:(tm)::™

:*:Faru::Frau
:*:Mashine::Machine
:*:Tunier::Turnier
:*:heir::hier
:*:Verküpfung::Verknüpfung



: Add ToolTip to tell whether always-on-top turned on or off
^+o::					; Strg+Shift+o
  WinSet, AlwaysOnTop, toggle, A
  WinGet, ExStyle, ExStyle, A
  Tooltip,  % (ExStyle & 0x8 = 0) ? "Always-On-Top OFF" : "Always-On-Top ON"
  Sleep, 1500
  Tooltip,
Return


^.::
	SoundGet, master_mute, MASTER, mute
	If master_mute = OFF
	{
		SoundBeep, 1500, 500
		SoundSet, +1, MASTER, mute, 1
		MsgBox, MASTER ist jetzt stummgeschaltet.
	}
	Else
	{
		SoundSet, +1, MASTER, mute, 1
		SoundBeep,750, 500
		MsgBox, MASTER ist nicht mehr stummgeschaltet.
	}
Return


!^i::                           ; Convert text to upper
 OldClipboard:= Clipboard
 Clipboard:= ""
 Send, ^c ;copies selected text
 ClipWait
 StringUpper Clipboard, Clipboard
 Send %Clipboard%
 Sleep 1000
 Clipboard:= OldClipboard
return

!^o::                           ; Convert text to lower
 OldClipboard:= Clipboard
 Clipboard:= ""
 Send, ^c ;copies selected text
 ClipWait
 StringLower Clipboard, Clipboard
 Send %Clipboard%
 Sleep 1000
 Clipboard:= OldClipboard
return

!^p::                           ; Convert text to capitalized
 OldClipboard:= Clipboard
 Clipboard:= ""
 Send, ^c ;copies selected text
 ClipWait
 StringUpper Clipboard, Clipboard, T
 Send %Clipboard%
 Sleep 1000
 Clipboard:= OldClipboard
return



^ö:: Send &ouml;
^ä:: Send &auml;
^ü:: Send &uuml;
^Ö:: Send &Ouml;
^Ä:: Send &Auml;
^Ü:: Send &Uuml;
^ß:: Send &szlig;


;---------------------------------------------------------------->
; Datum Uhrzeit
;---------------------------------------------------------------->


:*:.heute::  ; erstetzt .heute mit dem aktuellen Datum
FormatTime, CurrentDateTime,, dd. MMMM yyyy  
SendInput %CurrentDateTime%
return

^#F1::      ; gibt das aktuelle Datum aus STRG+Win+F1
FormatTime, TimeString, %A_NOW%, dd.MM.yyyy
Send, %TimeString%
return

:*:.jetzt::  ; erstetzt .jetzt mit dem aktuellen Uhrzeit
FormatTime, CurrentDateTime,, HH 'Uhr' mm  
SendInput %CurrentDateTime%
return

^#F2::      ; gibt die aktuelle Uhrzeit aus STRG+Win+F2
FormatTime, TimeString, %A_NOW%,  HH 'Uhr' mm
Send, %TimeString%
return



^b::  ; STRG+B-Hotkey
Send, {Ctrl down}c{Ctrl up}  ; Kopiert den markierten Text. ^c könnte man auch verwenden, allerdings ist diese Methode sicherer.
SendInput, <b>{Ctrl down}v{Ctrl up}</b> ; UmschlieÃŸt den markierten Text mit HTML-Tags, um ihn fett darzustellen.
return 


^+b::  ; STRG+Shift+B-Hotkey
Send, {Ctrl down}c{Ctrl up}  ; Kopiert den markierten Text. ^c könnte man auch verwenden, allerdings ist diese Methode sicherer.
SendInput, [{Ctrl down}v{Ctrl up}] ; Umschließt den markierten Text mit Markdown-Tags, um ihn als Link darzustellen.
return  


^#b::  ; STRG+Win+B-Hotkey
Send, {Ctrl down}c{Ctrl up}  ; Kopiert den markierten Text. ^c könnte man auch verwenden, allerdings ist diese Methode sicherer.
SendInput, <a href="index.htm" class="basis" title="" target="_new">{Ctrl down}v{Ctrl up}</a> ; Umschließt den markierten Text mit Markdown-Tags, um ihn als Link darzustellen.
return 



^#t::Suspend, Toggle

; STRG+ALT+b
^!b::
  KeyWait, Control ; avoid sticky key  
  KeyWait, Alt     ; avoid sticky key
  KeyWait, b       ; avoid sticky key
  BlockInput, On  ; turns off mouse and keyboard to prevent accidental deletion from input
    ;Send, ^a     ; lasse ich weg, damit nur das von mir markierte kopiert wird
    ;Sleep 100
    Send, ^c
    Sleep 100
    Click
  BlockInput, Off

  IfNotExist, %Bax_JobDir%
  {
    FileCreateDir, %Bax_JobDir%
  }

  WinGetTitle, WindowName, A

  StringReplace, WindowName, WindowName, `\, -, All
  StringReplace, WindowName, WindowName, `:, -, All

  FileAppend , %clipboard%, %Bax_JobDir%\bw_%A_Now%.txt
Return

^+i::
; IP Info
URLDownloadToFile,http://www.netikus.net/show_ip.html, %Bax_Start%\Files\showip.txt
if ErrorLevel = 1
  {
    MsgBox, 16,IpAddresses,Your public Ipaddress could not be detected.
  }
FileReadLINE,BaxIP,%Bax_Start%\Files\showip.txt, 1
MsgBox, 64,Ipaddresses,Your Public IpAddress is: [%BaxIP%]`n`nYour private ipAddress is: [%A_IPAddress2%]
FileDelete, %Bax_Start%\showip.txt
return
;--------------------------------------------------------------------------------------------------------
^+v::
OnMessage(0x53, "OnHelp")
Gui +OwnDialogs
MsgBox 0x4040, VarSchau, %A_ScriptName%`nBaxterWorks Variablen Tester Box Version 005:`n---------------------------------------------------`nBaxIP: %BaxIP%`nBax_Start: %Bax_Start%`nBax_JobDir: %Bax_JobDir%`nBax_Flex: %Bax_Flex%`nA_ScriptHwnd: %A_ScriptHwnd%`n`nA_LineFile: %A_LineFile%`nA_ComputerName: %A_ComputerName%`nA_Username: %A_Username%`nA_MyDocuments:  %A_MyDocuments%`nA_AppData: %A_AppData%`nA_WinDir: %A_WinDir%`n`nA_ComSpec: %A_ComSpec%`nA_Temp: %A_Temp%`nA_OSType: %A_OSType%`n`n, 60

IfMsgBox Timeout, {
WinClose
Gui, Destroy
}

OnHelp() {
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help.htm, %A_ScriptDir%\Files\help.htm
	}
	run,%A_ScriptDir%\Files\help.htm
}
return