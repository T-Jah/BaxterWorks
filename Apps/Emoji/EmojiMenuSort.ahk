;------------------------------------------------------------------------------------->
; AHK AutoHotKey Skript. Handbuch und HP: https://ahkde.github.io/
; (c) 2021 T-Jah Tom
; https://www.tombesch.de					   04/2021 Version 004
;------------------------------------------------------------------------------------->
; Autor: Jack Dunning, https://jacksautohotkeyblog.wordpress.com
; All the german words by Tom
;
; BaxterWorks Software:	http://www.baxterworks.de/software
;			http://blog.baxterworks.de
;------------------------------------------------------------------------------------->
;Titel: EmojiMenuSort


Menu Tray, Icon, %A_ScriptDir%\..\..\Grafix\cool.ico 	; #NoTrayIcon



^!e:: 
  OldClipboard:= ClipboardAll
  Clipboard:= ""
  Send, ^c ; copies selected text
  ClipWait 0
  If ErrorLevel
    {
      MsgBox, No Text Selected!
      Return
    }

  EmojiItems := ""
  Loop, read, EmojiInsert.ahk
  {
         If InStr(A_LoopReadLine,Trim(Clipboard)) and (A_LoopReadLine ~= "::")
         {
                  Emoji := StrSplit(A_LoopReadLine , ":")
                  Icon := StrSplit(Emoji[5], ";")
	EmojiItems := EmojiItems .  Emoji[3] . " | " . Trim(Icon[1]) . "`n"
        }
  }
  Sort, EmojiItems, U


  ItemCount := 0
  Loop, Parse, EmojiItems , `n
  {
      If ItemCount = 20
        {
          Menu, EmojiMenu, add, % A_LoopField, InsertEmoji, +BarBreak
          ItemCount := 1
         }  
       Else
         {
           Menu, EmojiMenu, add, % A_LoopField, InsertEmoji
           ItemCount++
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

InsertEmoji:

  EmojiIcon := StrSplit(A_ThisMenuItem , "|")

  SendInput, % Trim(EmojiIcon[2])

Return