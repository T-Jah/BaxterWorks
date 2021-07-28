BaxFunk_reloadAHK()
 {
    DetectHiddenWindows, On
    SetTitleMatchMode, 2
    WinGet, allAhkExe, List, ahk_class AutoHotkey
    Loop, % allAhkExe {
        hwnd := allAhkExe%A_Index%
        if (hwnd = A_ScriptHwnd)  ; Verhindert das Neuladen des aktuellen Fensters
        {
            continue
        }
        PostMessage, 0x0111, 65303,,, % "ahk_id" . hwnd
    }
    Reload
}

