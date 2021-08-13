CodeVersion := "1.0.0.5", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\cool.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright Jack Dunning & T-Jah Tom
;@Ahk2Exe-SetDescription Ersetzt Text durch Emojis
;@Ahk2Exe-SetFileVersion 1.0.0.5
;@Ahk2Exe-SetProductVersion 1.0.0.5
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks Jack Dunning
;@Ahk2Exe-SetName BaxterWorks EmojiMenu
;@Ahk2Exe-SetProductName EmojiMenu
;------------------------------------------------------------------------------------->
; AHK AutoHotKey Skript. Handbuch und HP: https://ahkde.github.io/
; (c) 2021 T-Jah Tom
; https://www.tombesch.de					   04/2021 Version 005
;------------------------------------------------------------------------------------->
; Autor: Jack Dunning, https://jacksautohotkeyblog.wordpress.com
; All the german words by Tom
;
; BaxterWorks Software:	http://www.baxterworks.de/software
;			http://blog.baxterworks.de
;------------------------------------------------------------------------------------->
;Titel: EmojiMenu
#Include %A_ScriptDir%\..\..\Function\BaxFunk_Exit.ahk


Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\cool.ico 	; #NoTrayIcon
#SingleInstance ignore
SetWorkingDir %A_ScriptDir%

;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   MacroBax  Variablen, zB Pfade     [Version 003]                                                                    │
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
	AppName = EmojiMenu
	Bax_help = help_emoji	
	Skriptvorlage = MacroBax_008
	Bax_Icon = %Bax_Start%\Grafix\klee.ico
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

GoSub,AppStart

					; STRG + Alt + ,
!^,::
  OldClipboard:= ClipboardAll
  Clipboard:= ""
  Send, ^c ; copies selected text
  ClipWait 0
  If ErrorLevel
    {
      MsgBox, No Text Selected!
      Return
    }


  ItemCount := 0
  Loop, read, EmojiInsert.ahk
  {
         If InStr(A_LoopReadLine,Trim(Clipboard)) and (A_LoopReadLine ~= "::")
         {
                 Emoji := StrSplit(A_LoopReadLine , ":")
                  Icon := StrSplit(Emoji[5], ";")
             	If ItemCount = 20
		{
		   Menu, EmojiMenu, add, % Emoji[3] . " | " . Trim(Icon[1]), InsertEmoji, +BarBreak
		   ItemCount := 1
		}  
		Else
		{
		  Menu, EmojiMenu, add, % Emoji[3] . " | " . Trim(Icon[1]), InsertEmoji
		  ItemCount++
		}
        }
  }

If ItemCount
{
  Menu, EmojiMenu, Show
; After selection or cancelation, the script deletes the menu.
  Menu, EmojiMenu, DeleteAll
}
Else
  MsgBox, No emojis found!

; Restore the old Clipboard contents.
  Clipboard := OldClipboard
Return


FileInstall, ..\..\Grafix\cool.ico, ..\..\Grafix\cool.ico, 0
;----------------------------------------
; Tray Start
;----------------------------------------

AppStart:
AppName=EmojiMenu

Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray,Add,%AppName%,BaxterWorks
Menu, Tray, Add  ; Erstellt eine Trennlinie.
Menu,Tray,Add,HP J. Dunning ,Dunning
Menu,Tray,Add,BaxterWorks Software,BaxterWorks
Menu, Tray, Add  ; Erstellt eine Trennlinie.
Menu, Tray, Add, Neu laden..., reload  ; Erstellt einen neuen Menüpunkt.
Menu, Tray, Add, Versionsinfo..., MenuVersion  ; Erstellt einen neuen Menüpunkt.
Menu, Tray, Add, Beenden..., Ende  ; Erstellt einen neuen Menüpunkt.
Menu,Tray,Tip,%AppName% %Codeversion%
Menu,Tray,Default,%AppName%
return

BaxterWorks:
run, http://www.baxterworks.de/software
return

Dunning:
run, https://jacksautohotkeyblog.wordpress.com
return

reload:
reload
return

Ende:
GoSub,GuiClose

MenuVersion:
run, ..\..\Log\Versionsinfo_EmojiMenu.txt
return

InsertEmoji:

  EmojiIcon := StrSplit(A_ThisMenuItem , "|")

  SendInput, % Trim(EmojiIcon[2])

Return

OnExit, ExitSub  
return


;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   EndSub MacroBax        [Version 005]                                                                     │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;


GuiEscape:
GuiClose:
ButtonCancel:
quit:
	IniWrite, %Lastseen% , %backuptxt%, Stats_%BaxNutzerName% , Lastseen
	IniWrite, %A_Now%_%AppName% , %backuptxt%, Stats_%BaxNutzerName% , LastLogIn
	IniWrite, %AppName%_%CodeVersion%_%Skriptvorlage%_%A_Now% , %userini%, Stats_%BaxNutzerName%, Nutzung_%AppName%
	FileAppend, Nutzung: %A_Now% %A_Tab% Nutzer: %BaxNutzerName%  %A_Tab% App: %AppName%`n , %Bax_Start%\Config\%A_ComputerName%.bax
ExitApp

ExitSub:
ExitApp
