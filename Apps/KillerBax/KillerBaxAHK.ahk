CodeVersion := "1.0.0.2", Firma := "BaxterWorks Software"
;@Ahk2Exe-Let U_version = %A_PriorLine~U)^(.+"){1}(.+)".*$~$2%
;@Ahk2Exe-Let U_company = %A_PriorLine~U)^(.+"){3}(.+)".*$~$2%
;@Ahk2Exe-SetMainIcon %A_ScriptDir%\..\..\Grafix\skull.ico
;@Ahk2Exe-SetCompanyName BaxterWorks Software
;@Ahk2Exe-SetCopyright (c) 1999-2021`, AHK Forum & T-Jah Tom
;@Ahk2Exe-SetDescription Tools und Skripte
;@Ahk2Exe-SetFileVersion 1.0.0.2
;@Ahk2Exe-SetProductVersion 1.0.0.2
;@Ahk2Exe-SetLanguage 0x0407
;@Ahk2Exe-SetLegalTrademarks BaxterWorks
;@Ahk2Exe-SetName BaxterWorks KillerBaxAHK
;@Ahk2Exe-SetProductName KillerBaxAHK


#SingleInstance Force
#NoEnv
SetBatchLines -1
SetWorkingDir %A_ScriptDir%


;http://www.autohotkey.com/forum/viewtopic.php?t=59801
DetectHiddenWindows, On

Gui, Add, ListView, r20 w600 gMyListView, Name|pid
WinGet, List, List, ahk_class AutoHotkey
gosub load_data
return

load_data:
LV_Delete()
Loop %List%
{
    WinGet, PID, PID, % "ahk_id " List%A_Index%
    If ( PID <> DllCall("GetCurrentProcessId") )
    {
    Wingettitle,name,% "ahk_id " List%A_Index%
    LV_Add("", Name, pid)
    msgbox,,, %pid%, 1
    }
}
LV_ModifyCol()
LV_ModifyCol(2,80)

LV_ModifyCol(2, "Integer center")
Gui, Show, autosize
return

MyListView:
if A_GuiEvent = DoubleClick
{
    LV_GetText(RowText, A_EventInfo,2)
    msgbox,260,,%rowtext% kill application?
    IfMsgBox, yes
    {
    ;Process, close,%rowtext%
   PostMessage,0x111,65405,0,,ahk_pid %rowtext%
    sleep 2000
    gosub load_data
    }
}

return

GuiClose:
ExitApp

