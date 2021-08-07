CodeVersion := "1.0.0.4", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\cool.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright Jack Dunning & T-Jah Tom
;@Ahk2Exe-SetDescription Ersetzt Text durch Emojis
;@Ahk2Exe-SetFileVersion 1.0.0.4
;@Ahk2Exe-SetProductVersion 1.0.0.4
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
applicationname=EmojiMenu

Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray,Add,%applicationname%,BaxterWorks
Menu, Tray, Add  ; Erstellt eine Trennlinie.
Menu,Tray,Add,HP J. Dunning ,Dunning
Menu,Tray,Add,BaxterWorks Software,BaxterWorks
Menu, Tray, Add  ; Erstellt eine Trennlinie.
Menu, Tray, Add, Neu laden..., reload  ; Erstellt einen neuen Menüpunkt.
Menu, Tray, Add, Versionsinfo..., MenuVersion  ; Erstellt einen neuen Menüpunkt.
Menu, Tray, Add, Beenden..., Ende  ; Erstellt einen neuen Menüpunkt.
Menu,Tray,Tip,%applicationname% %Codeversion%
Menu,Tray,Default,%applicationname%
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

GuiClose:


ExitSub:
ExitApp
