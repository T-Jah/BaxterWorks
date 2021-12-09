CodeVersion := "1.0.1.2", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\cool.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright Jack Dunning & T-Jah Tom
;@Ahk2Exe-SetDescription Ersetzt Text durch Emojis
;@Ahk2Exe-SetFileVersion 1.0.1.2
;@Ahk2Exe-SetProductVersion 1.0.1.2
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks Jack Dunning
;@Ahk2Exe-SetName BaxterWorks EmojiMenu
;@Ahk2Exe-SetProductName EmojiMenu
;------------------------------------------------------------------------------------->
; AHK AutoHotKey Skript. Handbuch und HP: https://ahkde.github.io/
; (c) 2021 T-Jah Tom
; https://www.tombesch.de					   08/2021 Version 014
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
	AppName = EmojiMenu
	Bax_help = help_emoji	
	Skriptvorlage = MacroBax_016
	Bax_Icon = %Bax_Start%\Grafix\cool.ico
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
	GoSub,TRAYMENU
	GoSub,STATS
	

;-----Skript------------------------------------------

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
; │   GUI, Traymenü   MacroBax            [Version 00x]    + komplett eigen mit SubTray                        │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;
TRAYMENU:

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
run, %A_ScriptDir%\..\..\Log\Versionsinfo_%AppName%.txt
return

InsertEmoji:

  EmojiIcon := StrSplit(A_ThisMenuItem , "|")

  SendInput, % Trim(EmojiIcon[2])

Return

OnExit, GuiEscape  
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
